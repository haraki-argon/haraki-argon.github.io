(() => {
    const section = document.querySelector("body > article > section");
    const heading = section?.querySelector(":scope > h2");

    if (!section || !heading || !Array.isArray(window.fileTags)) return;

    const files = window.fileTags;
    const tags = [
        ...new Set(files.flatMap(file => file.tags || []))
    ].filter(tag => typeof tag === "string" && !/[+\s]/.test(tag));

    const container = document.createElement("div");
    container.className = "file-browser";

    const tagPanel = document.createElement("fieldset");
    tagPanel.className = "file-tags";

    const tagLegend = document.createElement("legend");
    tagLegend.textContent = "选择标签";
    tagPanel.appendChild(tagLegend);

    const list = document.createElement("ul");
    list.className = "file-list";

    const selectedTags = new Set();

    const rawTagQuery = new URL(window.location.href).search
        .slice(1)
        .split("&")
        .find(parameter => parameter.startsWith("tags="))
        ?.slice("tags=".length);

    const requestedTags = (rawTagQuery || "")
        .split("+")
        .filter(Boolean)
        .map(tag => {
            try {
                return decodeURIComponent(tag);
            } catch {
                return "";
            }
        });

    for (const tag of requestedTags) {
        if (!/[+\s]/.test(tag) && tags.includes(tag)) {
            selectedTags.add(tag);
        }
    }

    function updateTagQuery() {
        const url = new URL(window.location.href);
        const otherParameters = url.search
            .slice(1)
            .split("&")
            .filter(parameter => parameter && !parameter.startsWith("tags="));

        if (selectedTags.size > 0) {
            const encodedTags = [...selectedTags]
                .map(tag => encodeURIComponent(tag))
                .join("+");
            otherParameters.push(`tags=${encodedTags}`);
        }

        url.search = otherParameters.length
            ? `?${otherParameters.join("&")}`
            : "";
        window.history.replaceState(null, "", url);
    }

    for (const tag of tags) {
        const label = document.createElement("button");
        label.type = "button";
        label.className = "file-tag";

        label.textContent = tag;
        label.setAttribute("aria-pressed", String(selectedTags.has(tag)));
        label.classList.toggle("selected", selectedTags.has(tag));

        label.addEventListener("click", () => {
            if (selectedTags.has(tag)) {
                selectedTags.delete(tag);
                label.classList.remove("selected");
                label.setAttribute("aria-pressed", "false");
            } else {
                selectedTags.add(tag);
                label.classList.add("selected");
                label.setAttribute("aria-pressed", "true");
            }

            updateTagQuery();
            renderFiles();
        });

        tagPanel.appendChild(label);
    }

    function renderFiles() {
        list.replaceChildren();

        const filteredFiles = files.filter(file => {
            if (selectedTags.size === 0) return true;
            return [...selectedTags].every(tag => file.tags?.includes(tag));
        });

        for (const file of filteredFiles) {
            const item = document.createElement("li");
            const link = document.createElement("a");

            const pathParts = file.path.split("/");
            const fileName = pathParts.at(-1);

            link.textContent = fileName;
            link.href = `/files/files/${pathParts.map(encodeURIComponent).join("/")}`;
            link.target = "_blank";
            link.rel = "noopener";

            item.appendChild(link);
            list.appendChild(item);
        }
    }

    container.append(tagPanel, list);
    heading.after(container);

    renderFiles();
})();