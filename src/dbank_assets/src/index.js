import { dbank } from "../../declarations/dbank";

window.addEventListener("load",  async function(){ // turn to async function because on motoko app check balance is a asyn function
  // console.log("Finished loading")
  update();
});

document.querySelector("form").addEventListener("submit", async function(event){
  event.preventDefault();
  console.log("submitted");

  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);
  // console.log(inputAmount, outputAmount)

  if(document.getElementById("input-amount").value !=0){
    await dbank.topUp(inputAmount);
  }

  if (document.getElementById("withdrawal-amount").value != 0){
    await dbank.withdraw(outputAmount);
  }

  await dbank.compound();
  
  update();

  button.removeAttribute("disabled");

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";



});

async function update(){
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = currentAmount.toFixed(2);
}