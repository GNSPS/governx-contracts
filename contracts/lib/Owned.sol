pragma solidity 0.4.15;


contract Owned {
    address public owner;
    modifier onlyOwner() { require(isOwner(msg.sender)); _; }

    function Owned() { owner = msg.sender; }

    function isOwner(address addr) public constant returns(bool) { return addr == owner; }

    function transfer(address _owner) onlyOwner {
        if (_owner != address(this)) {
            owner = _owner;
        }
    }
}
