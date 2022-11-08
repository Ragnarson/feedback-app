document.addEventListener("turbo:load", () => {
  const elements = [
    { datasetProperty: "show", classListMethod: "remove" },
    { datasetProperty: "hide", classListMethod: "add" },
    { datasetProperty: "toggle", classListMethod: "toggle" }
  ];

  // Enables hiding, showing or toggling visibility of data-{action} querySelector on click
  elements.forEach(({ datasetProperty, classListMethod }) => {
    document.querySelectorAll(`[data-${datasetProperty}]`).forEach(dataElement => {
      dataElement.addEventListener("click", () => {
        const target = dataElement.dataset[datasetProperty];
        document.querySelector(target).classList[classListMethod]("hidden");
      });
    });
  });
});
