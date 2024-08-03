const pay = () => {
  
  const payjp = Payjp('pk_test_e7039fd7d032898186af19dc')
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);

       const hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'token');
        hiddenInput.setAttribute('value', token);
        form.appendChild(hiddenInput);
        form.submit();
       
        
        console.log(token)
      }
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

  
window.addEventListener("turbo:load", pay);
document.addEventListener("DOMContentLoaded", function() {
  const element = document.getElementById('number-form');
  if (element) {
    element.addEventListener('input', function(event) {
      // Your event handler code
      console.error("Element #number-form not found");
    
    });
  }
});