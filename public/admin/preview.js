// Tailwind in admin preview (typography plugin)
window.CMS.registerPreviewStyle("https://cdn.tailwindcss.com?plugins=typography", { raw: false });

const RichPreview = ({ entry, widgetFor }) => {
  const data = entry.get("data");
  const title = data.get("title");
  const summary = data.get("summary");
  const body = widgetFor && widgetFor("body");
  return `
    <div class="min-h-screen bg-[linear-gradient(180deg,#0b1220_0%,#0f172a_100%)] text-white p-8">
      <div class="max-w-3xl mx-auto">
        <h1 class="text-4xl md:text-6xl font-extrabold tracking-tight text-center">${title || "Untitled"}</h1>
        ${summary ? `<p class="mt-4 text-center opacity-80">${summary}</p>` : ""}
        ${body ? `<article class="prose prose-invert max-w-none mt-8">${body}</article>` : ""}
      </div>
    </div>
  `;
};

window.CMS.registerPreviewTemplate("services", (props) => {
  const el = document.createElement("div");
  el.innerHTML = RichPreview(props);
  return el;
});
window.CMS.registerPreviewTemplate("product-groups", (props) => {
  const el = document.createElement("div");
  el.innerHTML = RichPreview(props);
  return el;
});
