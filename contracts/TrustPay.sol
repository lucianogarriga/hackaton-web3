// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

/**
 * @title TrustPay

    In a traditional linking relationship to make payments, there are three figures:

    A: is the user who wishes to pay for any service.
    B: is the traditional intermediary that charges a commission for the intermediation between two parties. 
    C: is the end user of the destination of the money.

    Use Case: 
    
    The proposed development here is a payment system, that includes custody 
    and distribution, aiming to simplify payments for the end users (A and C) and make
    the process more efficient. The dApp (decentralized Application) could do without 
    centralized intermediaries.

    Goals: 
    
    Reduce costs and speed up and secure financial transactions. 
    Operations become transparent and public, and every payment shows its traceability 
    with the origin and destiny of funds.
 */

contract TrustPay is Ownable {

    using Address for address payable;

    /*
    Events to call in many functions, to improve user experience
    */
    event Deposited(uint256 amount);
    event Withdrawn(address indexed payee, uint256 salary);

    event TenantAdded(string name, address userAddress, uint256 amount);
    event EmployeeAdded(string name, address userAddress, uint256 amount);

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
    function addTenants(string memory _name, address _userAddress, uint _amount) public onlyOwner {
        require(_tenants[_userAddress] == 0, "The tenant already exists or already has credits");
        _tenants[_userAddress] = _amount;
        emit TenantAdded(_name, _userAddress, _amount);
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
    function addEmployees(string memory _name, address _userAddress, uint _amount) public onlyOwner {
        require(_employees[_userAddress] == 0, "The employee already exists or already has credits");
        _employees[_userAddress] = _amount;
        emit EmployeeAdded(_name, _userAddress, _amount);
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
     * function withdraw()
     * Function to withdraw the employee's salary from the contract to the employee's address. 
     * The contract's available balance must be sufficient to cover the employee's salary.
     * It can only be called by employees.
     *
     * Emits a {Withdrawn} event.
     */
    function withdraw() public virtual onlyEmployee {
        uint256 salaryToPay = _employees[msg.sender];
        address contractAddress = address(this);
        uint256 contractBalance = contractAddress.balance;
        require(salaryToPay <= contractBalance, "Not enough funds");
        sendMoney(msg.sender, salaryToPay);
        emit Withdrawn(contractAddress, salaryToPay);
    }

    /* 
    * function checkUser().
    * Function to check what type of user is the address we pass in params.
    * @param _userAddress The address we need to check on which type of user is.
    */
    function checkUser(address _userAddress) public view returns (string memory) {
        if (_tenants[_userAddress] > 0) {
            return "The user is a Tenant.";
        } else if (_employees[_userAddress] > 0) {
            return "The user is an Employee.";
        } else {
            return "The user is not a Tenant or Employee";
        }
    }
}