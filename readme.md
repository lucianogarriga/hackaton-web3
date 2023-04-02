![ ](pics/logo.jpg "Trust Pay Logo")

# TRUST PAY

#### Project Context: Hackaton King of Devs 2.0

March 31, April 1st, April 2nd 2023

Organizers: [Think and Dev](https://thinkanddev.com/kingofdevs/)

Location: Cordoba, Argentina

###### Participants
* Luciano Martin Garriga
* Franco Cerino
* Federico Rascon
* Benjamin Juarez

###### Mentors
* Neri Bocchi (Ripio)
* Juan Ignacio Bocchi

#### Kick-Off, Brainstorming, and Prioritization

The Hackaton begins with a time limit of developing an idea in a little less than 3 consecutive days, and sets the agenda that teams can develop whatever they want as long as the concept is useful and makes good use of the properties that a web3 environment can provide. Additional criteria is that the development is expected to be original, complete and delivered with clean code and complete functionality.

The group that is proposing the current project firstly brainstormed ideas and came to four main contesting ideas to counter weight each against the other. To evaluate each of the possible ideas to develop, the group members built an evaluation system that would comply with the hackaton context.

The first two criteria to test ideas were originality(1), and viability(2). So for each of the four ideas, the group assigned a value for these 2 categories in a score from 1 to 10. The competing ideas at the top had similar scores. So in a second instance, the group adopted a third criteria: willingness(3) to develop.

In the end, came the winner, only leaving behind a very original idea that seemed complex to develop in the assigned time, and with a potential promise to develop in the future. The scores for the winner idea, from the point of view of the group was:

1. Originality: 8
2. Viability: 10
3. Willingness: 10
4. Total Score: 28

## ROADMAP

### Concept Idea

Painpoint detected: Services that have intermediaries always have an additional cost. So some payment systems entail a process in which, one party A pays to B, who then pays to C. 

Solution Approach: The workaround in web3 is that sometimes not all parties are required. So payer A can send assets directly to C without intermediary B. This allows for quicker processes and less expensive ones. 

Contextual Solution: In the local context of this project, the development aims to comply with legal regulations, which may require that the intermediary party still exists. If the project includes this party, B, then the web3 solution we propose could still provide more transparency and traceability to the process.

Use Case: The proposed development here is a payment system, that includes custody and distribution, aiming to simplify payments for the end users (A and C) and make the process more efficient. The dApp (decentralized Application) could do without centralized intermediaries.

Goal: Reduce costs and speed up and secure financial transactions. Operations become transparent and public, and every payment shows its traceability with the origin and destiny of funds.

#### Other Use Cases

The context and use case described above is only a fraction of what this analysis can tackle. The pain point is generic, and the use case for payments can be found in a wide array of situations.

The dApp can be used in any field in which payers and receivers coexist: employees, partners, collaborators, etc. The dApp can be used in environments such as corporations, collaborations, and businesses.

### Project Scope: Administration System for Buildings and Owners

A very common use case is the control of communal expenses that are handed into a fund and then used to pay expenses of the building, services, and employee salaries.

The idea from the project kick-off is to give a web3 solution that can be useful to a massive audience. Between the 1st party A, and the end user C the ideal plan would be to have FIAT payments and FIAT cashouts. Everything that happens in the middle should be fueled on the blockchain with Smart Contracts which make the flow secure, traceable, and simple. 

#### Users and UX

The system is aimed to be used with FIAT users with no knowledge of web3:
* Tenants
* Employees
* Admins

The user experience is expected to be as seamless as any web2 application, with the gains of working with web3 in the background.

### Project Rules and Limitations: Challenges To Overcome

What happens if:

* a tenant doesn't pay enough to cover the costs of the fund: salaries, or destination accounts? There could be a penalty such as a partial claim. Such tenants should also cover the fees for the transaction costs of activating the smart contract. 
* a tenant changes? or a tenant leaves and no one replaces them for a period of time?

### Color Palette

The spirit of the brand is to convey a serious tone in which users can rely on a system without thinking about how the technicalities workaround in the background. Blue is a cold color that represents objectivity, and calmness and does not raise alarms. The tones that aim to represent this perspective is a palette that is at the same time: simple, quick, effective, and most importantly secure and transparent. 

* Color Palette from [coolors.co: LINK  here](https://coolors.co/palette/03045e-023e8a-0077b6-0096c7-00b4d8-48cae4-90e0ef-ade8f4-caf0f8)

![ ](pics/color-palette.png "Hex Colors in Blue Tones")

### System Architecture Diagram

![ ](pics/architecture.png "System Architecture Diagram with dApp Wallet and Smart Contract")

* [Draw Diagram LINK in Google Public Folder](https://drive.google.com/file/d/1EvSddaOpwvGIHwQF9xLxwMdm0Nqso1Mr/view)

### Solidity Project - Documentation
31.00

1. `npm init –yess` 
(initialize a project with package.json) There is no configuration set up. Later, there will be more dependencies to install

2. `npm install –save-dev hardhat` 
(such as a dev dependency)

The next step is to create a Javascript project. We create a .gitignore file and more basic dependencies with hardhat and ether.js. Then, we have a greeter.sol file. At the start of the file, we must uncomment the next line to use console.log
`// import "hardhat/console.sol";`

3. Go to alchemy.com and create an account. This website provides a dashboard to view the interactions of addresses and smart contracts. 

We created a new app and we started with the Polygon Testnet (Mumbai). With that account, we have the following elements: API Key, HTTPS, and WebSockets to configure our account with the smart contract.

4. You have to install a Metamask Wallet and add the Mumbai Polygon Test Network like a new Testnet in your Metamask Wallet.

5. Go to Mumbai faucet to obtain some MATICS into your wallet in the Mumbai network, to pay the gas for your transactions.

6. Then, we are going to install one more tool called dotenv.  `npm install dotenv –save`. It creates an environment variable file. It's going to hold all of our secrets, including our Metamask private key, our alchemy API key, and any other things you don't want to add to your project.

7. Create a file called .env
Here we want to define our API URL and our Metamask private key.

We go to the Console terminal, and init an empty git repository, we tap a git add and we can see how the .gitignore file ignores the .env file to push into any github repository.

8. We want to update the hardhat configuration file.
We added a network object, with Mumbai, Polygon, for example, and inside every one of them, we added the URL and accounts with the private key. To obtain those variables, we require the .env file.

```
require("dotenv").config();
```

Add a line of code that loads the environment variables. 

``` 
const { API_URL, PRIVATE_KEY} = process.env;
```

9. Check the sample script file and config it.

10. Run the command `npx hardhat compile`, before deploying to testnet.

11. Run the command `npx hardhat run scripts/deploy.js` network Mumbai

### Done

* Idea Concept
* Branding
	* Product Naming
	* Logo 
	* Color Palette
* Readme Documentation version 2

### Upcoming Next 

* SmartContract: Smart contract deployed en Testent Polygon
* Research Frontend: libraries, examples, etc. Build the Dapp and connect Wallet
* Business Rules: Review case scenarios in which the tenants, and representative/leader of the community, may need to consider special situations such as extraordinary expenses.
* Installation and Deploy Guide
* List of used technologies, with links
* Bug acknowledgment and possible error corrections
* Frequently Asked Questions (FAQ)
* Copyrights, licenses, and legal considerations

### Additional Resources

* [Canva Presentation of the Project](https://www.canva.com/design/DAFe3QbNqq0/WziLfB7dX9QqUmERkc7V7w/edit?utm_content=DAFe3QbNqq0&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)
* [LINK on How to Document a Software Project](https://cs.uns.edu.ar/~ldm/mypage/data/oc/info/guia_para_la_documentacion_de_proyectos_de_software.pdf)
