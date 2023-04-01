// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

/**
 * @title TrustPay

    Use Case: The proposed development here is a payment system, that includes custody 
    and distribution, aiming to simplify payments for the end users (A and C) and make
    the process more efficient. The dApp (decentralized Application) could do without 
    centralized intermediaries.

    Goal: Reduce costs and speed up and secure financial transactions. 
    Operations become transparent and public, and every payment shows its traceability 
    with the origin and destiny of funds.
 */

contract TrustPay is Ownable {

    using Address for address payable;

    /*
    Events to call in many functions, to improve user experience
    */
    event Deposited(uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 salary);

    event TenantAdded(string tenantName, address tenantAddress, uint256 expenses);
    event EmployeeAdded(string employeeName, address employee, uint256 salary);

    mapping(address => uint256) private _tenants;
    mapping(address => uint256) private _employees;
    mapping(address => uint256) private _deposits;

    /*
     * modifier onlyTenant 
     * Only tenants who were added to _tenants mapping could call the function
     *
     */
    modifier onlyTenant {
        require(_tenants[msg.sender] != 0, "Sender is not a tenant");
        _;
    }

    /*
     * modifier onlyEmployee
     * Only employees who were added to _employees mapping could call the function
     *
     */
    modifier onlyEmployee {
        require(_employees[msg.sender] != 0, "Sender is not a employee");
        _;
    }

    /*
     * function getAddress 
     * Call this function to obtain the address of the contract
     *
     */
    function getAddress() public view returns (address){
        return address(this);
    }

    /*
     * function getBalance
     * Call this function to obtain the balance of the contract
     *
     */

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

    /*
     * function addTenants() 
     * Function that adds new tenants to the dApp.
     * It can only be called by the owner 
    *  @param _tenantName The name of the tenant to be added.
     * @param _tenantAddress The address of the tenant to be added.
     * @param _weiAmount The amount of expenses to be paid by the tenant.
     *
     * Emits a {TenantAdded} event.
     */ 
    function addTenants(string memory _tenantName, address _tenantAddress, uint _weiAmount) public onlyOwner {
        require(_tenants[_tenantAddress] == 0, "The tenant already exists or already has credits");
        _tenants[_tenantAddress] = _weiAmount;
        emit TenantAdded(_tenantName, _tenantAddress, _weiAmount);
    } 
    
    /*
     * function addEmployees() 
     * Function that adds new employees to the dApp.
     * It can only be called by the owner 
    *  @param _employeeName The name of the employee to be added.
     * @param _employeeAddress The address of the employee to be added.
     * @param _weiAmount The amount of salary to be claimed by the tenant.
     *
     * Emits a {EmployeeAdded} event.
     */ 
    function addEmployees(string memory _employeeName, address _employeeAddress, uint _weiAmount) public onlyOwner {
        require(_employees[_employeeAddress] == 0, "The employee already exists or already has credits");
        _employees[_employeeAddress] = _weiAmount;
        emit EmployeeAdded(_employeeName, _employeeAddress, _weiAmount);
    } 

    /*
     * function deposit()
     * Function of making an expense payment by any tenant.
     * It can only be called by tenants.
     *
     * Emits a {Deposited} event.
     */
    function deposit() public payable virtual onlyTenant {
        uint256 amount = msg.value;
        _deposits[msg.sender] += amount;
        emit Deposited(amount);
    }

    /*
     * function depositOf().
     * Function to view the amount deposited by the tenant's address.
     * @param payee The tenant's address to check the deposit amount.
     * 
     */
    function depositsOf(address payee) public view returns (uint256) {
        return _deposits[payee];
    }

    /* 
    * function sendMoney().
    * Function to transfer a specified amount value to the specified address.
    * It is also used in the withdrwa() function.
    * @param to The address of the transfer recipient.
    * @param value The amount of cryptocurrency to transfer.
    */
    function sendMoney(address to, uint value) public {
        address payable receiver = payable(to);
        receiver.transfer(value);
    }

    /*
    
    */
    function withdraw() public virtual onlyEmployee {
        uint256 salary = _employees[msg.sender];
        address contractAddress = address(this);
        uint256 contractBalance = contractAddress.balance;
        require(salary <= contractBalance, "Not enough funds");
        sendMoney(msg.sender, salary);
        emit Withdrawn(contractAddress, salary);
    }
}