document.addEventListener("DOMContentLoaded", () => {
  const matrix = document.getElementById("matrix");
  const listEl = document.getElementById("device-list");
  const saveBtn = document.getElementById("save-changes");
  const addColBtn = document.getElementById("add-col");
  const addRowBtn = document.getElementById("add-row");

  const labelMap = new Map();
  const placements = new Map();
  let rows = 0,
    cols = 0;

  function excelColumn(n) {
    let s = "";
    while (n >= 0) {
      s = String.fromCharCode(65 + (n % 26)) + s;
      n = Math.floor(n / 26) - 1;
    }
    return s;
  }

  function renderMatrix() {
    matrix.style.gridTemplateColumns = `repeat(${cols},60px)`;
    matrix.innerHTML = "";
    for (let r = 1; r <= rows; r++) {
      for (let c = 1; c <= cols; c++) {
        const cell = document.createElement("div");
        cell.className = "cell empty";
        cell.dataset.row = r;
        cell.dataset.col = c;
        cell.addEventListener("dragover", (e) => e.preventDefault());
        cell.addEventListener("dragenter", (e) => {
          e.preventDefault();
          cell.classList.add("drag-over");
        });
        cell.addEventListener("dragleave", () =>
          cell.classList.remove("drag-over")
        );
        matrix.appendChild(cell);
      }
    }
  }

  function executeDragInit() {
    document.querySelectorAll(".module").forEach((mod) => {
      const placed = placements.has(mod.dataset.id);
      mod.draggable = true;
      mod.classList.toggle("placed", placed);
      mod.ondragstart = (e) => {
        e.dataTransfer.setData("text/plain", mod.dataset.id);
        e.dataTransfer.setData("origin", placed ? "grid" : "sidebar");
        if (placed) {
          const p = mod.parentElement;
          setTimeout(() => {
            p.classList.add("empty");
            p.innerHTML = "";
          }, 0);
        }
      };
    });
  }

  function placeModule(cell, id) {
    const label = labelMap.get(id) || id;
    cell.classList.remove("empty");
    cell.innerHTML = `<div class="module placed" data-id="${id}" data-label="${label}">${label}</div>`;
    placements.set(id, { row: +cell.dataset.row, col: +cell.dataset.col });
    executeDragInit();
  }

  function removeFromGrid(id) {
    const pos = placements.get(id);
    if (!pos) return;
    const cell = matrix.querySelector(
      `.cell[data-row="${pos.row}"][data-col="${pos.col}"]`
    );
    if (cell) {
      cell.classList.add("empty");
      cell.innerHTML = "";
    }
    placements.delete(id);
    executeDragInit();
  }

  function redrawPlaced() {
    const ids = Array.from(placements.keys());
    ids.forEach((id) => {
      const pos = placements.get(id);
      const cell = matrix.querySelector(
        `.cell[data-row="${pos.row}"][data-col="${pos.col}"]`
      );
      if (cell && cell.classList.contains("empty")) {
        placeModule(cell, id);
      }
    });
  }

  matrix.addEventListener("dragover", (e) => e.preventDefault());
  matrix.addEventListener("drop", (e) => {
    e.preventDefault();
    matrix
      .querySelectorAll(".cell.drag-over")
      .forEach((c) => c.classList.remove("drag-over"));

    const id = e.dataTransfer.getData("text/plain");
    const origin = e.dataTransfer.getData("origin");
    const x = e.clientX,
      y = e.clientY;

    let closest = null,
      minDist = Infinity;
    matrix.querySelectorAll(".cell.empty").forEach((cell) => {
      const r = cell.getBoundingClientRect();
      const cx = r.left + r.width / 2,
        cy = r.top + r.height / 2;
      const d = Math.hypot(x - cx, y - cy);
      if (d < minDist) {
        minDist = d;
        closest = cell;
      }
    });

    if (closest) {
      const rr = closest.getBoundingClientRect();
      const inside =
        x >= rr.left && x <= rr.right && y >= rr.top && y <= rr.bottom;
      if (inside || minDist <= 100) {
        placeModule(closest, id);
        return;
      }
    }
    if (origin === "grid") removeFromGrid(id);
  });

  listEl.addEventListener("dragover", (e) => e.preventDefault());
  listEl.addEventListener("drop", (e) => {
    e.preventDefault();
    const id = e.dataTransfer.getData("text/plain");
    const origin = e.dataTransfer.getData("origin");
    if (origin === "grid") removeFromGrid(id);
  });

  saveBtn.addEventListener("click", async () => {
    const data = Array.from(placements.entries()).map(([id, pos]) => ({
      slotId: id,
      row: pos.row,
      col: pos.col,
    }));
    try {
      await fetch("/api/parksets/update", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ placements: data }),
      });
      alert("Changes saved!");
    } catch (err) {
      console.error(err);
      alert("Failed to save changes");
    }
  });

  addColBtn.addEventListener("click", () => {
    cols++;
    renderMatrix();
    redrawPlaced();
    executeDragInit();
  });
  addRowBtn.addEventListener("click", () => {
    rows++;
    renderMatrix();
    redrawPlaced();
    executeDragInit();
  });

  async function refreshParkSets() {
    try {
      const res = await fetch("/api/parksets");
      const json = await res.json();
      renderDeviceList(json.park_sets);
    } catch (err) {
      console.error("Failed to fetch park sets:", err);
    }
  }

  function renderDeviceList(parkSets) {
    listEl.innerHTML = "";
    parkSets.forEach((ps, sectionIndex) => {
      const section = document.createElement("div");
      section.className = "section";
      const letter = excelColumn(sectionIndex);
      section.innerHTML = `<h2>Section ${letter}</h2>`;

      ps.lots.forEach((lot, lotIndex) => {
        const mod = document.createElement("div");
        const label = `${letter}${lotIndex + 1}`;
        labelMap.set(lot.park_lot_id, label);

        mod.className = "module";
        mod.dataset.id = lot.park_lot_id;
        mod.dataset.state = lot.state;
        mod.dataset.label = label;
        mod.textContent = label;
        section.appendChild(mod);
      });

      listEl.appendChild(section);
    });

    rows = cols = 0;
    parkSets.forEach((ps) => {
      ps.lots.forEach((lot) => {
        if (lot.row > rows) rows = lot.row;
        if (lot.column > cols) cols = lot.column;
      });
    });

    renderMatrix();
    executeDragInit();

    parkSets.forEach((ps) => {
      ps.lots.forEach((lot) => {
        if (lot.row !== undefined && lot.column !== undefined) {
          const cell = matrix.querySelector(
            `.cell[data-row="${lot.row}"][data-col="${lot.column}"]`
          );
          if (cell && cell.classList.contains("empty")) {
            placeModule(cell, lot.park_lot_id);
          }
        }
      });
    });
  }

  refreshParkSets();
});
