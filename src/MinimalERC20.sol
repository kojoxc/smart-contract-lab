// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract MinimalERC20 {
    string public name;
    string public symbol;
    uint8 public constant DECIMALS = 18;

    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    error Unauthorized();
    error InsufficientBalance();
    error InsufficientAllowance();

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        _onlyOwner();
        _;
    }

    function _onlyOwner() internal view {
        if (msg.sender != owner) revert Unauthorized();
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        uint256 allowed = allowance[from][msg.sender];
        if (allowed < amount) revert InsufficientAllowance();

        unchecked {
            allowance[from][msg.sender] = allowed - amount;
        }

        _transfer(from, to, amount);
        return true;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        totalSupply += amount;
        balanceOf[to] += amount;

        emit Transfer(address(0), to, amount);
    }

    function burn(uint256 amount) external {
        uint256 balance = balanceOf[msg.sender];
        if (balance < amount) revert InsufficientBalance();

        unchecked {
            balanceOf[msg.sender] = balance - amount;
            totalSupply -= amount;
        }

        emit Transfer(msg.sender, address(0), amount);
    }

    function _transfer(address from, address to, uint256 amount) private {
        uint256 balance = balanceOf[from];
        if (balance < amount) revert InsufficientBalance();

        unchecked {
            balanceOf[from] = balance - amount;
        }
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);
    }
}
