

<h1 align="center">BlueBubble</h1>

<div align="center">
  <a href="https://github.com/MartinGurasvili/BlueBubble">
    <img width="200" height="200" alt="cas" src="https://user-images.githubusercontent.com/76784461/186772559-40d2691d-8ee5-4743-b16d-80078dd09ea6.png">
  </a>

  <p align="center">
    <br>
    This is a Decentralised Peer to Peer Chat Application. That makes sure only necessary data is Decentralised whilst the majority is local to the device. Loaded with a modern UI and features other P2P apps lack.
    <br>
     <br>
    </p>
    <h1 align="center">Working Progress 👷🏽‍♂️</h1>
    <div align="center">
    <img  style="width:40%" alt="3" src="https://user-images.githubusercontent.com/76784461/188469333-1ccc966d-623b-4d62-b080-7747e910d42c.png">
    <img  style="width:40%" alt="2" src="https://user-images.githubusercontent.com/76784461/190514201-ff40af7e-1138-4b9c-98db-0689f4fa0799.png">



</div>
<div align="center">
  <img  style="width:40%" alt="2" src="https://user-images.githubusercontent.com/76784461/190025520-e8231609-e6d2-4a08-a429-3cfddb71db13.png">
    <img style="width:40%"  alt="1" src="https://user-images.githubusercontent.com/76784461/190025204-e6a9f96c-7106-4410-b44c-a39f3aa1798d.png">
    
</div>
<br>
<h1 align="center">The Next Steps</h1>
    <div align="center">
    <p align="center">
    Like with every software, it is never truely finished - you can always add new features, make more improvements - so hear is an explaination of the current state of the project - and how I would propose the next step in development would be - if I did decide to develop this software further in the future or if you decide to try :)
    <br>
     <br>
    </p>
    </div>
    <h1 align="center">Current Architecture Model</h1>
    <div align="center">
    <img alt="2" src="https://user-images.githubusercontent.com/76784461/193937588-e07c9b89-6826-4dd0-87fc-7a45fefc4315.png">
    <p align="center">
    This model assumes that both devices have already added eachother to their contacts - using their Unique ID <br>
    <br>
    <h3>Establishing Peer to Peer Connection</h3>
    🔹 When wanting to send or receive a message - you have to open the messaging tab with their contact. <br>
    🔹 You computer searches for a premade connection or then a temporary server that is hosted by the contact<br>
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
    Therefore if the contact is offline all the messages sent would not reach them, only to be saved locally on the senders device <br>
    Also, this solution is IP dependant if IP is changed - device will not be able to send and recieve messages until IP is set back to original <br>
    </p>

</div>
<br>
<h1 align="center">Proposed Architecture Model</h1>
    <div align="center">
    <img alt="2" src="https://user-images.githubusercontent.com/76784461/193946852-766fa7b0-379e-425a-b310-c50b2f28fe86.png">
    <p align="center">
    This model is based of a torrent - distributed file model  <br>
    This model assumes that all contacts have a unique encryption key between them. <br>
    <br>
    <h3>Getting Offline Messages</h3>
    🔹 When opening the application - your device downloads the latest Database from the other users that are online <br>
    🔹 You check if any entrys in the DB are older than 5 Days - if so delete them <br>
    🔹 All your messages in the DB are encrypted with different encryption keys based on contact  <br>
    🔹 You decrypt your messages, save them locally to each contacts chat and delete them from the DB  <br>
    <h3>Sending Offline Messages</h3>
    🔹 Only if your contact is offline<br>
    🔹 You Upload your encrypted message to the DB - where others connected users will download it <br>
    🔹 To prevent DDOS and bloating of the DB - upload requests are limited <br>
     <br>
     <br>
     <h2>Downsides</h2>
      Even Though all of the downsides of the current solution are mitigated with this implementation, there are still downsides to this approch<br><br>
      This relies on at least one user to have the application running as if no one else is connected there is no DB to send and recive data from and therefore it wouldnt be passed onto the intended user<br>
      Due to everyone having eachothers data - a user could theoratically brueforce the encryption, therefore they would be able to read your messages sent offline - with that shared induvidual<br>
      If requests are not handled correclty the DB for everyone would be bloated and involve a large download <br>
      Scalability of this solution would be varied - as more people connect the file download is faster and more reliable as more sources to fetch the data from, however would also result in a larger DB size to download<br>
    </p>

</div>
<h1 align="center">-Summary-</h1>
    <div align="center">
    <p align="center">
    This was a really fun project to work on<br>
    I overcame lots of challenge; Improved my knowledege of numerouse programming languages; Improved on my design skills; Learned alot about networking and cybersecurity and most importantly, made something really cool 😎
    </p>
    </div>

 
