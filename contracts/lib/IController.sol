pragma solidity 0.4.15;

contract IController {
    function hasVoted(uint256 _proposalID, address _sender) public constant returns (bool);
    function numMomentsOf(uint256 _proposalID) public constant returns (uint256);
    function momentSenderOf(uint256 _proposalID, uint256 _momentID) public constant returns (address);
    function momentValueOf(uint256 _proposalID, uint256 _momentID) public constant returns (uint256);
    function momentTimeOf(uint256 _proposalID, uint256 _momentID) public constant returns (uint256);
    function momentBlockOf(uint256 _proposalID, uint256 _momentID) public constant returns (uint256);
    function momentNonceOf(uint256 _proposalID, uint256 _momentID) public constant returns (uint256);
    function weightOf(uint256 _proposalID, uint256 _position) public constant returns (uint256);
    function voteOf(uint256 _proposalID, uint256 _momentID, uint256 _index) public constant returns (bytes32);
    function hasExecuted(uint _proposalID) public constant returns (bool);
    function metadataOf(uint256 _proposalID) public constant returns (string);
    function numDataOf(uint256 _proposalID) public constant returns (uint256);
    function dataOf(uint256 _proposalID, uint256 _index) public constant returns (bytes32);

    function numProposals() public constant returns (uint256 numProposals);
    function nonces(address _sender) public constant returns (uint256);

    function newProposal(string _metadata, bytes32[] _data) public payable returns (uint proposalID);
    function vote(uint256 _proposalID, bytes32[] _data) public payable;
    function execute(uint256 _proposalID) public payable;
    function calldata(uint256 _proposalID, uint256 _start, uint256 _length) public constant returns (bytes);

    function canPropose(address _sender, uint256 _proposalID) public constant returns (bool);
    function canVote(address _sender, uint256 _proposalID) public constant returns (bool);
    function canExecute(address _sender, uint256 _proposalID) public constant returns (bool);
    function votingWeightOf(address _sender, uint256 _proposalID, uint256 _index, uint256 _data) public constant returns (uint256);
    function voteOffset(address _sender, uint256 _proposalID) public constant returns (uint256);
    function executionOffset(address _sender, uint256 _proposalID) public constant returns (uint256);

    event ProposalMoment(address _sender, uint256 _momentID, uint256 _proposalID);
 }
