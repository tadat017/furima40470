const setPriceCalculation = () => {
  const priceInput = document.getElementById('item-price');
  if (!priceInput) return;

  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;

    if (inputValue >= 300 && inputValue <= 9999999) {
      const tax = Math.floor(inputValue * 0.1);
      const profit = Math.floor(inputValue - tax);
      addTaxDom.innerHTML = tax.toLocaleString();
      profitDom.innerHTML = profit.toLocaleString();
    } else {
      addTaxDom.innerHTML = '';
      profitDom.innerHTML = '';
    }
  });
};
 
window.addEventListener('turbo:load', setPriceCalculation);
window.addEventListener('turbo:render', setPriceCalculation);
