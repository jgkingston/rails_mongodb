
// Dependency injection

var IndexCtrl = function($scope) {

  $scope.displayValue = 0
  $scope.pendingOperation = "add"; 
  // $scope.lastOperation = "";
  $scope.runningTotal = 0;
  $scope.pendingValue = 0 ;
  $scope.newNumber = true;
  $scope.firstEntry = true

  $scope.operators = {
   'add': function(a, b){ return a+b},
   'subtract': function(a, b){ return a-b},
   'divide': function(a, b){ return a/b},
   'multiply': function(a, b){ return a*b}
  };

  $scope.buildNumber = function(input) {
    // When hit a button on the calculator after resolving an operation it should clear the console and display the new number
    if ($scope.newNumber == true) {
      $scope.displayValue = input
      $scope.newNumber = false
      }
    // The plus minus button should change the sign of the displayed value, otherwise the calculator should build the base-ten number
    else {
      if (input >= 0){
        $scope.displayValue = $scope.displayValue * 10 + input
        }
      else {
        $scope.displayValue = -($scope.displayValue)
        }
    }
  };

  $scope.setOperator = function(operator){
    // The first entry behaves a little differently
    if ($scope.firstEntry == true){
      $scope.runningTotal = $scope.displayValue
      $scope.firstEntry = false
    }
    else if ($scope.newNumber == false) {
      $scope.pendingValue = $scope.displayValue
      $scope.doMath()
      $scope.pendingOperation = operator;
    }
    $scope.pendingOperation = operator;

    if ($scope.newNumber == false) {
      $scope.pendingValue = $scope.displayValue
      $scope.displayValue = $scope.runningTotal
      $scope.newNumber = true
    }
    else {
      $scope.newNumber = true;
    }
  }

  $scope.doMath = function(){
    if ($scope.firstEntry == true){
      $scope.runningTotal = $scope.displayValue
      $scope.newNumber = true
    }
    else {
      $scope.pendingValue = $scope.displayValue
      $scope.runningTotal = $scope.operators[$scope.pendingOperation]($scope.runningTotal, $scope.pendingValue)
      $scope.displayValue = $scope.runningTotal
      $scope.newNumber = true
      $scope.pendingOperation = "add"
      $scope.pendingValue = 0
    }
  };

  $scope.clearAll =  function(){
    $scope.displayValue = 0;
    $scope.runningTotal = 0;
    $scope.pendingValue = 0;
    $scope.firstEntry = true
  };
}