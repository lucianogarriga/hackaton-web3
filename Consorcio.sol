// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Employee.sol";
import "./Tenant.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Consorcio is Ownable {

    address public consorcioAddress;

    Tenant[] private tenantList;
    Employee[] private employeeList;

    Employee private aEmployee;
    Tenant private aTenant;

    event salariesPaid();

    receive() external payable { }
    fallback() external payable { }

    constructor() payable { 
        
    } 

    modifier isEnoughbalance (uint _amount) {
        require(address(this).balance >= _amount, "Fondos insuficientes");
        _;
    }

    function getTotalSalaries() private view returns(uint) {
        uint totalSalaries = 0;
        for (uint i; i > employeeList.length; i ++){
            totalSalaries += employeeList[i].getSalary();
        }
        return totalSalaries;
    }

    function showAddress() public view returns (address){
        return address(this);
    }
    function showConsBalance() public view returns (uint) {
        return address(this).balance;
    }

    // funcion para crear un nuevo tenant con sus propiedades y agregarlo al tenantList
    function addNewTenant(string memory _name, uint _servicePrice) public { 
        tenantList.push(new Tenant(_name, _servicePrice));  
    }
    // funcion para saber la cantidad de tenant creados y guardados en tenantList
    function tenantArray() public view returns(uint){  
        uint tLenght = tenantList.length;
        return tLenght;  
    }  

    //funcion para crear un nuevo employee con sus propiedades y agregarlo al employeeList
    function addNewEmployee(string memory _name, address _withdrawAddress, string memory _profession, uint salary) 
    public onlyOwner { 
        employeeList.push(new Employee(_name, _withdrawAddress, _profession, salary));
    }
    //funcion para saber la cantidad de employee creados y guardados en employeeList
    function employeeArray() public view returns (uint) {
        uint eLength = employeeList.length;
        return eLength;
    }
    //funcion para depositar al Employee creado
    // function depositEmployee() public payable{
    //     (bool sent,) = aEmployee.getAddress().call{
    //         value: msg.value
    //     }("");
    //     require(sent == true, "Employee no pudo recibir fondos");
    // }
}