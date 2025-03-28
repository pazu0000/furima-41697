   const price = () => {
    const priceInput = document.getElementById("item_price");
    const addTaxInput = document.getElementById("add-tax-price")
    const profitInput = document.getElementById("profit");

    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const tax = Math.floor(inputValue * 0.1);
      const profit = inputValue - tax;

      addTaxInput.innerHTML = tax;
      profitInput.innerHTML = profit;

    });
  };
  
    window.addEventListener("turbo:load", price);
    window.addEventListener('turbo:render', price);