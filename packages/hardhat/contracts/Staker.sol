// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  // 2.1 Declarar el mapping de los balances y el threshold que debe lograr la 🐮 Vaca.
  mapping(address => uint256) public balances;
	uint256 public threshold = 1 ether;

  // 3.1 Declarar un deadline de 30 segundos después de desplegado el contrato.
    uint256 public deadline = block.timestamp + 30 seconds;

  // 2.2 Declarar el evento Stake() que registrará dos cosas: address y amount
    event Stake(address indexed sender, uint256 amount);

  // 3.3 Crear un modifier que la Vaca no esté completa
  modifier stakeNotCompleted() {
    bool completed = exampleExternalContract.completed();
    require(!completed, "staking process already completed");
    _;
  }

  // 3.4 Crear otro modifier que verifique que el deadline no se ha cumplido
  modifier deadlinePassed(bool requireDeadlinePassed) {
    uint256 timeRemaining = timeLeft();
    if (requireDeadlinePassed) {
      require(timeRemaining <= 0, "El deadline no ha pasado todavía");
    } else {
      require(timeRemaining > 0, "El deadline ya pasó");
    }
    _;
  }

  constructor(address exampleExternalContractAddress) {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  // 2.3 Implementar la función stake() como paybale para actualizar el balance
  function stake() public payable {
    // 2.3.1 Actualizar el balance
    balances[msg.sender] += msg.value;
    // 2.3.2 Emitir el evento que notifica a la blockchain que un sender a enviado una cantidad
    emit Stake(msg.sender, msg.value);
  }

  // After some `deadline` allow anyone to call an `execute()` function

  // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`


  // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance


  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
  // 3.2 Crear función que permite contabilizar el tiempo restante.
  function timeLeft() public view returns (uint256 timeleft) {
    if( block.timestamp >= deadline ) {
      return 0;
    } else {
      return deadline - block.timestamp;
    }
  }

  // Add the `receive()` special function that receives eth and calls stake()

}
