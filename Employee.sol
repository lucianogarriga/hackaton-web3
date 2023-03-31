// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BaseUser.sol";

contract Employee is BaseUser {

    // declaramos var globales de estado, y los modificadores inician con _
    string private profession;
    uint private immutable salary;
    address withdrawAddress;

    constructor (
        string memory _name,
        address _withdrawAddress,
        string memory _profession,
        uint _salary
    ) // para llamar al padre => llamarlo luego de los parametros del constructor
    BaseUser (_name) {
        withdrawAddress = _withdrawAddress;
        profession = _profession;
        salary = _salary;
    }
    //Como salary ha sido declarada como private, 
    //se declara una funcion que obtiene a salary como parametro
    //y luego al ser publica se la puede llamar desde otro contrato
    function getSalary () public view returns(uint){
        return salary;
    }

    function withdrawal (uint _amount) public {
        //valida si el balance del contrato es >= al valor del servicio
        require(address(this).balance >= _amount, "Fondos insuficientes");
        // un bool si es true, realiza la transferencia al address que indicamos
        (bool success,) = withdrawAddress.call{
            value: _amount
        }("");
        //require(success == true, "Fallo la transferencia") - otra opcion;
        emit WithdrawalSuccess(success, address(this).balance);
    } 

    function getEmpAddress() public view returns(address){
        return address(this);
    }
}