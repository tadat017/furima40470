const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);

  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); 
    console.log("フォーム送信時にイベント発火");

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        console.error("Token generation error: ", response.error.message);
      } else {
        const token = response.id;
        console.log(token);
        const tokenObj = `<input type="hidden" name="token" value="${token}">`; 
        form.insertAdjacentHTML("beforeend", tokenObj); 

        
        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);