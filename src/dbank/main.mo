import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";


actor DBank {
  stable var currentValue: Float = 300;
  // currentValue := 300;
  Debug.print(debug_show(currentValue));
  // type Time = Int;
  // let now : () -> Time;
  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show(startTime));


  let id = 192929292292;

  // Debug.print(debug_show(id));

  public func topUp(amount: Float) { // private function: only accesible within this actor, add public to be able to call it from the outside
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };


  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("You dont have enough")
    }
  };

  // read only operation

  public query func checkBalance(): async Float{
    return currentValue;
  };
  // topUp();

  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * 1.01 ** Float.fromInt(timeElapsedS);
    startTime := currentTime;
  };
}