pragma solidity ^0.4.15;

contract Msg {
    
    address owner;
    
    event Message(address indexed _sender, address indexed _receiver, uint256 _time, string message);
    
    struct message
    {
        address from;
        string  text;
    }
    
    function Msg() {
        owner = msg.sender;
    }
    
    mapping (address => uint256) public last_msg_index;
    mapping (address => mapping (uint256 => message)) public messages;
    
    function lastIndex(address _owner) constant returns (uint256)
    {
        return last_msg_index[_owner];
    }
    
    function getMessageByIndex(address _who, uint256 _index) constant returns (address, string)
    {
        return (messages[_who][_index].from, messages[_who][_index].text);
    }
    
    function getLastMessage(address _who) constant returns (address, string)
    {
        require(last_msg_index[_who] > 0);
        return (messages[_who][last_msg_index[_who] - 1].from, messages[_who][last_msg_index[_who] - 1].text);
    }
    
    function sendMessage(address _to) returns (address)
    {
        messages[_to][last_msg_index[_to]].from = msg.sender;
        messages[_to][last_msg_index[_to]].text = "Hello World";
        last_msg_index[_to]++;
        Message(msg.sender, _to, now, "Hello World");
        return msg.sender;
    }
    
    function sendMessage1(address _to, string _text) returns (address)
    {
        messages[_to][last_msg_index[_to]].from = msg.sender;
        messages[_to][last_msg_index[_to]].text = _text;
        last_msg_index[_to]++;
        Message(msg.sender, _to, now, _text);
        return msg.sender;
    }
    
}