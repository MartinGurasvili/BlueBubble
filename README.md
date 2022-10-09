<h1 align="center">BlueBubble</h1>

<div align="center">
    <img width="200" height="200" alt="cas" src="https://user-images.githubusercontent.com/76784461/186772559-40d2691d-8ee5-4743-b16d-80078dd09ea6.png">
    <p align="center">
      <br>
      This is a Decentralised Peer to Peer Chat Application. That makes sure only necessary data is Decentralised whilst the majority is local to the device. Loaded with a modern UI and features other P2P apps lack.
      <br />
      <br>
      <br />
      <a href=https://github.com/MartinGurasvili/BlueBubble/releases/download/v1.0.0M/Blue.Bubble.app.zip"><h3><img width="20px" height="20px" alt="apple" src="https://user-images.githubusercontent.com/76784461/154564937-57c93aa0-69f8-497c-97d6-33b1d7d411e0.png"> Install Now</h3></a>
      <p><a href="https://github.com/MartinGurasvili/Calculator/releases/download/v1.0.0w/Calculator.zip"><h3><img style="width:20px"  alt="win" src="https://pnggrid.com/wp-content/uploads/2021/06/Windows-11-Icon-Logo.png"> Coming Soon</h3></a>
      <br></p>

 


<h1 align="center">Demo - Gallery</h1>
</div>
<div align="center">
<img style="width:40%"  alt="1" src="https://user-images.githubusercontent.com/76784461/194754796-5f7d34a5-302e-403b-ad60-d78f4284e072.png">


</div>
<div align="center">
<img  style="width:40%" alt="2" src="https://user-images.githubusercontent.com/76784461/190025520-e8231609-e6d2-4a08-a429-3cfddb71db13.png">
<img style="width:40%"  alt="1" src="https://user-images.githubusercontent.com/76784461/190025204-e6a9f96c-7106-4410-b44c-a39f3aa1798d.png">
<img style="width:70%" alt="2" src="https://user-images.githubusercontent.com/76784461/194154199-c61602fd-3932-4fb1-b0cc-2cc2b4629338.gif">
<p align="center">
    The Demonstration above shows the login proccess - showing that only a username is needed - allowing users to stay anonymous
    </p>
    
<p align="center">
(My Machine to the left) (Virtual Machine to the right)<br>
    The Demonstration above shows adding and messaging between two machines on different networks
    </p>
    
 
</div>
<br>
<h1 align="center">The Next Steps</h1>
    <div align="center">
    <p align="center">
    Like with every software, it is never truly finished - you can always add new features, make more improvements - so hear is an explanation of the current state of the project - and how I would propose the next step in development would be - if I did decide to develop this software further in the future or if you decide to try :)
    <br>
     <br>
    </p>
    </div>
    <h1 align="center">Current Architecture Model</h1>
    <div align="center">
    <img alt="2" src="https://user-images.githubusercontent.com/76784461/193937588-e07c9b89-6826-4dd0-87fc-7a45fefc4315.png">
    <p align="center">
    This model assumes that both devices have already added each other to their contacts - using their Unique ID <br>
    <br>
    <h3>Establishing Peer to Peer Connection</h3>
    🔹 When wanting to send or receive a message - you must open the messaging tab with their contact. <br>
    🔹 Your computer searches for a premade connection or then a temporary server that is hosted by the contact<br>
    🔹 If none of the above is found - your device becomes the host - and waits for a connection from the contacts IP and Port <br>
    🔹 When both devices are connected to the temp server - Port Hole punching occurs and the temp server is terminated  <br>
    🔹 Now as long as one of the devices keeps the application running they can both exchanges messages - Privately and Securely
     <br>
    </p>

</div>
<h2 align="center">Current Downsides</h2>
    <div align="center">
    <p align="center">
    This Current Model Lacks a major feature of offline messaging - due to it being serverless.<br>
    Therefore if the contact is offline all the messages sent would not reach them, only to be saved locally on the sender's device <br>
    Also, this solution is IP dependant if IP is changed - device will not be able to send and receive messages until IP is set back to original <br>
    </p>

</div>
<br>
<h1 align="center">Proposed Architecture Model</h1>
    <div align="center">
    <img alt="2" src="https://user-images.githubusercontent.com/76784461/193946852-766fa7b0-379e-425a-b310-c50b2f28fe86.png">
    <p align="center">
    This model is based on torrent - distributed file model  <br>
    This model assumes that all contacts have a unique encryption key between them. <br>
    <br>
    <h3>Getting Offline Messages</h3>
    🔹 When opening the application - your device downloads the latest Database from the other users that are online <br>
    🔹 You check if any entries in the DB are older than 5 Days - if so delete them <br>
    🔹 All your messages in the DB are encrypted with different encryption keys based on contact  <br>
    🔹 You decrypt your messages, save them locally to each contact’s  chat and delete them from the DB  <br>
    <h3>Sending Offline Messages</h3>
    🔹 Only if your contact is offline<br>
    🔹 You Upload your encrypted message to the DB - where others connected users will download it <br>
    🔹 To prevent DDOS and bloating of the DB - upload requests are limited <br>
     <br>
     <br>
     <h2>Downsides</h2>
      Even Though all of the downsides of the current solution are mitigated with this implementation, there are still downsides to this approach<br><br>
      This relies on at least one user to have the application running as if no one else is connected there is no DB to send and receive  data from and therefore it wouldn’t be passed onto the intended user<br>
      Due to everyone having each other’s data - a user could theoretically brute force the encryption, therefore they would be able to read your messages sent offline - with that shared individual.<br>
      If requests are not handled correctly  the DB for everyone would be bloated and involve a large download <br>
      Scalability of this solution would be varied - as more people connect the file download is faster and more reliable as more sources to fetch the data from, however would also result in a larger DB size to download<br>
    </p>

</div>
<h1 align="center">-Summary-</h1>
    <div align="center">
    <p align="center">
    This was a really fun project to work on<br>
    I overcame lots of challenge; Improved my knowledge of numerous programming languages; Improved on my design skills; Learned a lot about networking and cybersecurity and most importantly, made something really cool 😎
    </p>
    </div>

 
