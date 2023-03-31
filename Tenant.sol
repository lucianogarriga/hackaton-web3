// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BaseUser.sol";

contract Tenant is BaseUser {

    // debemos definir el valor de las expensas y el address del consorcio
    uint private servicePrice; 

    event ExpensesPaid(uint pricePaid);  
 
    constructor (
        string memory _name,
        //address _withdrawAddress,
        uint _servicePrice
    ) payable BaseUser (_name) {
        servicePrice = _servicePrice; 
    }

    //utiliza el valor de _servicePrice p/ comparar cuanto debe enviar al Consorcio
    //lo utilizamos para validar si tenant tiene el balance suficiente para pagarlo
    function payExpenses(address consorcioAddress) public {
        //valida si el balance del contrato es >= al valor del servicio
        require(address(this).balance >= servicePrice, "Fondos insuficientes");
        // un bool si es true, realiza la transferencia al address que indicamos
        (bool sent,) = consorcioAddress.call{
            value: servicePrice
        }("");
        require(sent == true, "Fallo la transferencia");
        emit ExpensesPaid(servicePrice);
    } 
}