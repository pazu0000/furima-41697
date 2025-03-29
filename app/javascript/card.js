document.addEventListener("DOMContentLoaded", () => {
  console.log("✅ DOMContentLoaded で読み込まれた！");
});

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

  
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        alert("カード情報が正しくありません");
      } else {
        const token = response.id;
        const tokenInput = document.createElement("input");
        tokenInput.setAttribute("type", "hidden");
        tokenInput.setAttribute("name", "token");
        tokenInput.setAttribute("value", token);
        form.appendChild(tokenInput);
        form.submit(); 
      }

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    });
  });
;



