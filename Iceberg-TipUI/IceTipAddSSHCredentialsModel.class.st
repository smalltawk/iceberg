"
I implement the dialog to add SSH credentials.
"
Class {
	#name : #IceTipAddSSHCredentialsModel,
	#superclass : #IceTipAbstractSSHCredentialsModel,
	#instVars : [
		'hostLabel',
		'hostInput'
	],
	#category : #'Iceberg-TipUI-Credentials'
}

{ #category : #layout }
IceTipAddSSHCredentialsModel class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #hostLabel width: self labelWidth;
				   add: #hostInput;
				   yourself)
		  height: self inputTextHeight;
		  add: (SpBoxLayout newLeftToRight
				   add: #usernameLabel width: self labelWidth;
				   add: #usernameInput;
				   yourself)
		  height: self inputTextHeight;
		  add: #publicKeyInput height: self inputTextHeight;
		  add: #privateKeyInput height: self inputTextHeight;
		  add: (SpBoxLayout newLeftToRight
				   add: #passphraseLabel width: self labelWidth;
				   add: #passphraseInput;
				   yourself)
		  height: self inputTextHeight
]

{ #category : #actions }
IceTipAddSSHCredentialsModel >> accept [

	self acceptAddAction
]

{ #category : #accessing }
IceTipAddSSHCredentialsModel >> hostnameFromInput [
	
	^ hostInput text
]

{ #category : #initialization }
IceTipAddSSHCredentialsModel >> initialExtentForWindow [

	^ (350 @ (self class inputTextHeight * 7 + self class buttonHeight))
		  scaledByDisplayScaleFactor
]

{ #category : #initialization }
IceTipAddSSHCredentialsModel >> initializePresenters [

	super initializePresenters.
	hostLabel := self newLabel
		label: 'Host: ';
		yourself.
	hostInput := self newTextInput
		autoAccept: true;
		whenTextChangedDo: [ self updateOkButton ];
		yourself
]

{ #category : #accessing }
IceTipAddSSHCredentialsModel >> newCredentials [
	
	^ IceSshCredentials new
		username: self username;
		publicKey: self publicKey;
		privateKey: self privateKey;
		keyPassphrase: self passphrase;
		yourself 
]

{ #category : #initialization }
IceTipAddSSHCredentialsModel >> titleForWindow [

	^ 'Add SSH credential'
]
