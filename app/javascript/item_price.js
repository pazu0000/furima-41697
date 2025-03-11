
window.addEventListener("turbo:load", () => {
  const priceInput = document.getElementById("item_price");
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const tax = priceInput.value;
      const profit = priceInput.value;

      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
      const profitDom = document.getElementById("profit")
      profitDom.innerHTML = Math.floor(inputValue - (addTaxDom.innerHTML));

    })
});



