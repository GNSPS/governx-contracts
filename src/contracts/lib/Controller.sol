pragma solidity ^0.4.15;

import "lib/Proposable.sol";
import "lib/DefaultRules.sol";
import "lib/ProxyBased.sol";


contract Controller is ProxyBased, Proposable, DefaultRules {
    modifier shouldPropose { _; require(canPropose(msg.sender, numProposals - 1)); }
    modifier shouldVote (uint256 _proposalID) { _; require(canVote(msg.sender, _proposalID)); }
    modifier shouldExecute (uint256 _proposalID) { require(canExecute(msg.sender, _proposalID)); _; }
    modifier transferFunds { if (msg.value > 0) { require(proxy.send(msg.value)); } _; }

    function newProposal(string _metadata, bytes _data) public payable transferFunds isMoment(numProposals) shouldPropose returns (uint proposalID) {
        proposalID = numProposals++;
        proposals[proposalID].metadata = _metadata;
        proposals[proposalID].data = _data;
    }

    function vote(uint256 _proposalID, bytes32[] _data) public payable transferFunds isMoment(_proposalID) shouldVote(_proposalID) {
        proposals[_proposalID].votes[proposals[_proposalID].moments.length] = _data;
        for(uint256 i; i < _data.length; i++)
            proposals[_proposalID].weights[i] += votingWeightOf(msg.sender, _proposalID, i, uint256(_data[i]));
    }

    function execute(uint256 _proposalID) public payable transferFunds isMoment(_proposalID) shouldExecute(_proposalID) {
        require(!proposals[_proposalID].executed);
        proposals[_proposalID].executed = true;
        bytes memory data = proposals[_proposalID].data;

        assembly {
            let data_length := mload(data)
            let end := add(data, data_length)
            let mc := add(data, 0x20)

            for {}  lt(mc, end) {} {
                let addr := div(mload(mc), 0x1000000000000000000000000)
                mc := add(mc, 0x14)

                let v := mload(mc)
                mc := add(mc, 0x20)

                let length := mload(mc)
                mc := add(mc, 0x20)

                switch call(gas, addr, v, mc, length, 0, 0)
                case 0 { stop }
                mc := add(mc, length)
            }
        }
    }
}
