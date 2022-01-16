//change test values in package.json package.json 

const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const { interface, bytecode } = require('../compile');

const web3 = new Web3(ganache.provider());

let accounts;
let contrct;
beforeEach(async ()=>{
    //To get a list of accounts
    //always returns promise

    //web3.(any cryptocurrency).(function)
    /* web3.eth.getAccounts().then(fetchedAccounts => {
        console.log(fetchedAccounts);
    }); */

    accounts = await web3.eth.getAccounts();
    contrct=await new web3.eth.Contract(interface).deploy({data:bytecode, arguments:[123]}).send({from : accounts[0], gas:'1000000'});
});

describe('Testing', ()=>{
    // To test whether the contract is deployed or not
    it('Deployed a contract', ()=>{
        // console.log(contrct);
        assert.ok(contrct.options.address);
    });

    //testing Constructor
    it('Constructor check', async()=>{
        // console.log(contrct);
        const cid = await contrct.methods.centerId().call();
        assert.equal(cid, 123);
    });

    //To test CheckQuality function
    it('Quality Checking Function', async ()=>{
        const value = await contrct.methods.checkQuality().call();
        assert.equal(value, 5);
    });

    //To test addMilk function
    it('Adding Milk', async ()=>{
        await contrct.methods.addMilk(1,25).send({from : accounts[0], gas:'1000000'});
        const value = await contrct.methods.getTotalQuantity().call();
        assert.equal(value, 25);
    });

    //To test getDatabyId function
    it('Getting data by Id', async ()=>{
        await contrct.methods.addMilk(1,25).send({from : accounts[0], gas:'1000000'});
        const val=await contrct.methods.getDataByID(1).call();
        // console.log(val);
        assert.equal(val[0], 25);
    });

    it('resetting milk quantity', async () =>{
        await contrct.methods.setMilkZero().send({from : accounts[0], gas:'1000000'});
        const val=await contrct.methods.getTotalQuantity().call();
        assert.equal(val, 0);
    });
});