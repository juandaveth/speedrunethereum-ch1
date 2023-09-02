// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  // 2.1 Declarar el mapping de los balances y el threshold que debe lograr la 🐮 Vaca.
  mapping(address => uint256) public balances;
	uint256 public threshold = 1 ether;

  // 2.2 Declarar el evento Stake() que registrará dos cosas: address y amount
    event Stake(address indexed sender, uint256 amount);

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
  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  // ( Make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )
  //function stake() public payable {
    // En esta función quiero hacer una sumatoria del valor stakeado en cada transacción
    // const totalStaked 
    // msg.value += msg.value;
  //}

  // After some `deadline` allow anyone to call an `execute()` function

  //function execute() public payable {
    // Cuando se ejecute esta función, tomaré el valor del msg.value que tomaré de la función stake.
  //}

  // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`


  // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance


  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend


  // Add the `receive()` special function that receives eth and calls stake()

}
