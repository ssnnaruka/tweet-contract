pragma solidity ^0.4.15;

contract Rel {
    
    event Message(address indexed _sender, address indexed _receiver, uint256 _time, string message);
    event Vote(address indexed _sender, address indexed _receiver, uint256 _time, uint vType);

    address owner;
    
    function Rel() public {
        owner = msg.sender;

    
    struct tweetRel
    {
        uint up;
        uint down;
        uint32 total;
        mapping (address => bool) isVote;
    }
    
    mapping (uint256 => tweetRel) public tweetRels;
    
    modifier isAlreadyVoted(uint256 _txHash, address _from) {
        require(tweetRels[_txHash].isVote[_from] == false);
        _;
    }
    
    function upVote(uint256 _txHash, address _from) public isAlreadyVoted(_txHash,  _from) {
        tweetRels[_txHash].up++;
        tweetRels[_txHash].total++;
        tweetRels[_txHash].isVote[_from] = true;
        Vote(_from, owner, now, 1);
    }
    
    function downVote(uint256 _txHash, address _from) public isAlreadyVoted(_txHash, _from) {
        tweetRels[_txHash].down++;
        tweetRels[_txHash].total++;
        tweetRels[_txHash].isVote[_from] = true;
        Vote(_from, owner, now, 1);
    }
    
    function getRelevence(uint256 _txHash) {
        tweetRels[_txHash];
    }
    
    
}

contract RelLog {
    
    uint upM = 90;
    
    event RelEve(uint a, string b);
    
    function getRelLog(uint up, uint down, uint32 total) public returns (string) {
        if((total * upM / 100) < up) {
            RelEve(up, "Green");
            return "Green";
        } else {
            RelEve(up, "Red");
            return "Red";
        }
    }
}