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

    event Deposited(uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);

    event tenantAdded(address tenant, uint256 weiAmount);
    event employeeAdded(address employee, uint256 weiAmount);

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

    // function for adding tenants (address) and allocating funds
    function addTenants(address _tenantAddress, uint _weiAmount) public {
        require(_tenants[_tenantAddress] == 0, "The tenant already exists or already has credits");
        _tenants[_tenantAddress] = _weiAmount;
        emit tenantAdded(_tenantAddress, _weiAmount);
    } 
    
    // function for adding employees (address) and allocating funds
    function addEmployees(address _employeeAddress, uint _weiAmount) public {
        require(_employees[_employeeAddress] == 0, "The employee already exists or already has credits");
        _employees[_employeeAddress] = _weiAmount;
        emit employeeAdded(_employeeAddress, _weiAmount);
    } 

    function depositsOf(address payee) public view returns (uint256) {
        return _deposits[payee];
    }

    /*
     * @dev Stores the sent amount as credit to be withdrawn.
     * @param payee The destination address of the funds.
     *
     * Emits a {Deposited} event.
     */
    function deposit() public payable virtual onlyTenant {
        uint256 amount = msg.value;
        _deposits[msg.sender] += amount;
        emit Deposited(amount);
    }

    function sendMoney(address to, uint value) public {
        address payable receiver = payable(to);
        receiver.transfer(value);
    }

    function withdraw() public virtual onlyEmployee {
        uint256 salary = _employees[msg.sender];
        address contractAddress = address(this);
        uint256 contractBalance = contractAddress.balance;
        require(salary <= contractBalance, "Not enough funds");

        sendMoney(msg.sender, salary);

        emit Withdrawn(contractAddress, salary);
    }
}