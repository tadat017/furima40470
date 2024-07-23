window.addEventListener('turbo:load', () => {
  
  const priceInput = document.getElementById('item-price');
  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;


    if (inputValue >= 300 && inputValue <= 9999999) {
      const tax = Math.floor(inputValue * 0.1);
      console.log(tax); 
      const profit = Math.floor(inputValue - tax);
       console.log(profit);
      addTaxDom.innerHTML = tax.toLocaleString();
      profitDom.innerHTML = profit.toLocaleString();
    } else {
      addTaxDom.innerHTML = '';
      profitDom.innerHTML = '';
    }
  });
});