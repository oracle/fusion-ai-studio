/* Copyright © 2026, Oracle and/or its affiliates. ** Licensed under the Universal Permissive License (UPL), Version 1.0  as shown at oss.oracle.com/licenses/upl */
/* Native interactions for the documentation site. No JavaScript framework. */
(() => {
  "use strict";

  const all = (selector, root = document) => Array.from(root.querySelectorAll(selector));
  const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)");
  const mobile = window.matchMedia("(max-width: 76.234375em)");
  const read = key => {
    try { return window.__md_get(key); } catch { return null; }
  };
  const save = (key, value) => {
    try { window.__md_set(key, value); } catch { /* Storage may be unavailable. */ }
  };
  document.documentElement.classList.remove("no-js");
  document.documentElement.classList.add("js", "native-runtime");

  // Keep diagrams as a separate optional renderer, without the theme runtime.
  const diagrams = all("pre.mermaid").map(pre => {
    const source = (pre.querySelector("code") || pre).textContent;
    const container = document.createElement("div");
    container.className = "native-diagram";
    pre.replaceWith(container);
    return { container, source };
  });
  let renderer;
  let diagramQueue = Promise.resolve();
  function loadRenderer() {
    if (window.mermaid?.run) return Promise.resolve(window.mermaid);
    if (!renderer) renderer = new Promise((resolve, reject) => {
      const script = document.createElement("script");
      script.src = "https://unpkg.com/mermaid@11/dist/mermaid.min.js";
      script.onload = () => window.mermaid?.run
        ? resolve(window.mermaid) : reject(new Error("Diagram renderer unavailable"));
      script.onerror = () => reject(new Error("Diagram renderer unavailable"));
      document.head.append(script);
    });
    return renderer;
  }
  function renderDiagrams() {
    if (!diagrams.length) return;
    diagramQueue = diagramQueue.then(async () => {
      try {
        const mermaid = await loadRenderer();
        mermaid.initialize({ startOnLoad: false, securityLevel: "strict",
          theme: document.body.dataset.mdColorScheme === "slate" ? "dark" : "default" });
        // Render independently so one invalid diagram cannot hide the others.
        for (let index = 0; index < diagrams.length; index++) {
          const { container, source } = diagrams[index];
          try {
            const { svg, bindFunctions } = await mermaid.render(`native-diagram-${index}`, source);
            container.innerHTML = svg;
            bindFunctions?.(container);
          } catch {
            showDiagramSource(container, source);
          }
        }
      } catch {
        diagrams.forEach(({ container, source }) => showDiagramSource(container, source));
      }
      scheduleScroll();
    });
  }
  function showDiagramSource(container, source) {
    const pre = document.createElement("pre");
    const code = document.createElement("code");
    code.textContent = source;
    pre.append(code);
    const status = document.createElement("p");
    status.className = "native-diagram-status";
    status.textContent = "Diagram preview unavailable. Diagram source is shown below.";
    container.replaceChildren(status, pre);
  }

  // Preserve the existing palette storage format and system preference default.
  const palette = all('[data-md-component="palette"] input[type="radio"]');
  const systemDark = window.matchMedia("(prefers-color-scheme: dark)");
  let chosenScheme = read("__palette")?.color?.scheme;
  function applyPalette(input, persist = false) {
    if (!input) return;
    palette.forEach(option => { option.checked = option === input; });
    ["scheme", "primary", "accent"].forEach(key => {
      document.body.setAttribute(`data-md-color-${key}`, input.getAttribute(`data-md-color-${key}`));
    });
    // Each selected radio's next label points at the other palette option.
    palette.forEach(option => { if (option.nextElementSibling) option.nextElementSibling.hidden = option !== input; });
    if (persist) {
      chosenScheme = input.dataset.mdColorScheme;
      save("__palette", { color: { scheme: chosenScheme, media: input.dataset.mdColorMedia,
        primary: input.dataset.mdColorPrimary, accent: input.dataset.mdColorAccent } });
      renderDiagrams();
    }
  }
  function defaultPalette() {
    const scheme = chosenScheme || (systemDark.matches ? "slate" : "default");
    applyPalette(palette.find(input => input.dataset.mdColorScheme === scheme) || palette[0]);
  }
  defaultPalette();
  palette.forEach(input => input.addEventListener("change", () => { if (input.checked) applyPalette(input, true); }));
  systemDark.addEventListener("change", () => { if (!chosenScheme) { defaultPalette(); renderDiagrams(); } });

  // Native checkbox controls retain Material's CSS drawer and section layouts.
  const drawer = document.getElementById("__drawer");
  const sidebar = document.querySelector('.md-sidebar--primary');
  const drawerButton = document.querySelector('.md-header__button[for="__drawer"]');
  all('label[for]').forEach(label => {
    const input = document.getElementById(label.htmlFor);
    if (!input || !input.matches('input[type="checkbox"], input[name="__palette"]') || label.classList.contains("md-overlay")) return;
    label.setAttribute("role", "button");
    label.tabIndex = 0;
    if (input.type === "checkbox") {
      const update = () => label.setAttribute("aria-expanded", String(input.checked));
      input.addEventListener("change", update);
      update();
    }
    if (input === drawer) label.setAttribute("aria-label", label === drawerButton ? "Open navigation" : "Close navigation");
    else if (!label.textContent.trim() && label.title) label.setAttribute("aria-label", label.title);
    label.addEventListener("keydown", event => {
      if (event.target !== label) return;
      if (event.key === "Enter" || event.key === " ") { event.preventDefault(); label.click(); }
    });
  });
  function updateDrawer() {
    const open = Boolean(drawer?.checked && mobile.matches);
    document.body.classList.toggle("native-drawer-open", open);
    if (sidebar) {
      sidebar.inert = mobile.matches && !open;
      if (open) { sidebar.setAttribute("role", "dialog"); sidebar.setAttribute("aria-modal", "true"); sidebar.setAttribute("aria-label", "Navigation"); }
      else { sidebar.removeAttribute("role"); sidebar.removeAttribute("aria-modal"); sidebar.removeAttribute("aria-label"); }
    }
  }
  drawer?.addEventListener("change", updateDrawer);
  mobile.addEventListener("change", updateDrawer);
  updateDrawer();
  function closeDrawer() {
    if (drawer?.checked) { drawer.checked = false; drawer.dispatchEvent(new Event("change")); }
  }
  document.addEventListener("keydown", event => {
    if (!drawer?.checked || !mobile.matches) return;
    if (event.key === "Escape") { closeDrawer(); drawerButton?.focus(); }
    if (event.key === "Tab" && sidebar) {
      const focusable = all('a[href], button, [tabindex="0"], summary', sidebar).filter(el => el.getClientRects().length);
      const first = focusable[0], last = focusable[focusable.length - 1];
      if (!sidebar.contains(document.activeElement) || (!event.shiftKey && document.activeElement === last)) { event.preventDefault(); first?.focus(); }
      else if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last?.focus(); }
    }
  });
  sidebar?.addEventListener("click", event => { if (event.target.closest("a[href]")) closeDrawer(); });

  // Accessible content tabs, including keyboard selection and linked labels.
  const tabSets = all(".tabbed-set").map((set, setIndex) => {
    const labels = all(":scope > .tabbed-labels > label", set);
    const panels = all(":scope > .tabbed-content > .tabbed-block", set);
    const inputs = labels.map(label => document.getElementById(label.htmlFor));
    set.querySelector(":scope > .tabbed-labels")?.setAttribute("role", "tablist");
    labels.forEach((label, index) => {
      label.id ||= `native-tab-${setIndex}-${index}`;
      label.setAttribute("role", "tab");
      inputs[index].tabIndex = -1;
      inputs[index].setAttribute("aria-hidden", "true");
      if (panels[index]) {
        panels[index].id ||= `native-panel-${setIndex}-${index}`;
        panels[index].setAttribute("role", "tabpanel");
        panels[index].setAttribute("aria-labelledby", label.id);
        label.setAttribute("aria-controls", panels[index].id);
      }
      label.addEventListener("click", event => { event.preventDefault(); selectTab(tabs, index, true); });
      label.addEventListener("keydown", event => {
        let next = index;
        if (event.key === "ArrowRight") next = (index + 1) % labels.length;
        else if (event.key === "ArrowLeft") next = (index + labels.length - 1) % labels.length;
        else if (event.key === "Home") next = 0;
        else if (event.key === "End") next = labels.length - 1;
        else if (event.key !== "Enter" && event.key !== " ") return;
        event.preventDefault(); selectTab(tabs, next, true); labels[next].focus();
      });
    });
    const tabs = { labels, inputs, panels };
    selectTab(tabs, Math.max(0, inputs.findIndex(input => input.checked)));
    return tabs;
  });
  function selectTab(tabs, selected, linked = false) {
    tabs.labels.forEach((label, index) => {
      const active = index === selected;
      tabs.inputs[index].checked = active;
      label.tabIndex = active ? 0 : -1;
      label.setAttribute("aria-selected", String(active));
      if (tabs.panels[index]) tabs.panels[index].hidden = !active;
    });
    if (linked) {
      const text = tabs.labels[selected].textContent.trim();
      tabSets.forEach(other => {
        const match = other.labels.findIndex(label => label.textContent.trim() === text);
        if (other !== tabs && match >= 0) selectTab(other, match);
      });
      save("__tabs", tabSets.map(other => other.labels[other.inputs.findIndex(input => input.checked)]?.textContent.trim()).filter(Boolean));
    }
  }

  function revealHash() {
    let target;
    try { target = document.getElementById(decodeURIComponent(location.hash.slice(1))); } catch { return; }
    if (!target) return;
    for (let parent = target.parentElement; parent; parent = parent.parentElement) {
      if (parent.matches("details")) parent.open = true;
    }
    tabSets.forEach(tabs => {
      const index = tabs.inputs.indexOf(target);
      const panel = tabs.panels.findIndex(el => el === target || el.contains(target));
      if (index >= 0 || panel >= 0) selectTab(tabs, Math.max(index, panel));
    });
  }
  window.addEventListener("hashchange", revealHash);
  revealHash();

  // Scroll tracking uses one animation frame per scroll/resize batch.
  const header = document.querySelector('[data-md-component="header"]');
  const title = document.querySelector('[data-md-component="header-title"]');
  const heading = document.querySelector("article h1");
  const topButton = document.querySelector('[data-md-component="top"]');
  const toc = all('[data-md-component="toc"] a[href*="#"]').map(link => {
    try { return { link, target: document.getElementById(decodeURIComponent(new URL(link.href).hash.slice(1))) }; }
    catch { return { link, target: null }; }
  }).filter(item => item.target);
  let frame = 0;
  function scheduleScroll() { if (!frame) frame = requestAnimationFrame(updateScroll); }
  function updateScroll() {
    frame = 0;
    const height = header?.getBoundingClientRect().height || 0;
    document.documentElement.style.setProperty("--native-header-height", `${height}px`);
    header?.classList.toggle("md-header--shadow", window.scrollY > 0);
    title?.classList.toggle("md-header__title--active", Boolean(heading && heading.getBoundingClientRect().bottom < height));
    if (topButton) { topButton.hidden = window.scrollY < 400; topButton.disabled = topButton.hidden; }
    let active = toc[0];
    toc.forEach(item => { if (item.target.getBoundingClientRect().top <= height + 48) active = item; });
    toc.forEach(item => {
      item.link.classList.toggle("md-nav__link--active", item === active);
      if (item === active) item.link.setAttribute("aria-current", "location");
      else item.link.removeAttribute("aria-current");
    });
  }
  topButton?.addEventListener("click", () => window.scrollTo({ top: 0, behavior: reducedMotion.matches ? "instant" : "smooth" }));
  window.addEventListener("scroll", scheduleScroll, { passive: true });
  window.addEventListener("resize", scheduleScroll, { passive: true });
  scheduleScroll();
  renderDiagrams();
})();
