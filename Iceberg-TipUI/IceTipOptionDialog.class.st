"
I'm a dialog that has different options. 
I'm a abstract class, I need to be used  through my children.

I'm kind of a ""tabbed"" dialog, but my options are ""mac style"": lateral and not top.

This is useful to keep a variable number of options.
"
Class {
	#name : #IceTipOptionDialog,
	#superclass : #IceTipSpPresenter,
	#instVars : [
		'typeList',
		'type',
		'contentPanel'
	],
	#category : #'Iceberg-TipUI-View'
}

{ #category : #layout }
IceTipOptionDialog class >> defaultLayout [

	^ SpPanedLayout newLeftToRight
		  positionOfSlider: 30 percent;
		  add: #typeList;
		  add: #contentPanel;
		  yourself
]

{ #category : #actions }
IceTipOptionDialog >> accept [

	^ [ 
	  self doAccept.
	  true ]
		  on: IceError , IceWarning
		  do: [ :e | 
			  e acceptError: IceTipInteractiveErrorVisitor new.
			  false ]
]

{ #category : #accessing }
IceTipOptionDialog >> allTypes [

	^ self subclassResponsibility
]

{ #category : #'accessing - ui' }
IceTipOptionDialog >> contentPanel [

	^ contentPanel
]

{ #category : #accessing }
IceTipOptionDialog >> contextSelection [

	^ type
]

{ #category : #actions }
IceTipOptionDialog >> doAccept [

	self subclassResponsibility
]

{ #category : #initialization }
IceTipOptionDialog >> initialExtentForWindow [

	^ (600 @ 300) scaledByDisplayScaleFactor
]

{ #category : #initialization }
IceTipOptionDialog >> initializeDialogWindow: aWindowPresenter [

	super initializeDialogWindow: aWindowPresenter.
	aWindowPresenter okAction: [ self doAccept ].
	aWindowPresenter whenOpenedDo: [ self typeList selectIndex: 1 ]
]

{ #category : #initialization }
IceTipOptionDialog >> initializePresenters [

	super initializePresenters.
	contentPanel := self newNullPresenter.
	typeList := self newTable.
	self initializeTypeList.

]

{ #category : #initialization }
IceTipOptionDialog >> initializeTypeList [

	typeList
		hideColumnHeaders;
		addColumn: ((SpImageTableColumn evaluated: #iconForWindow) width: 20);
		addColumn: (SpStringTableColumn evaluated: #titleForWindow);
		whenSelectionChangedDo: [ :selection | 
			self selectionChanged: selection selectedItem ];
		items: self allTypes
]

{ #category : #private }
IceTipOptionDialog >> replacePanelWith: aType [

	contentPanel := aType.
	self needRebuild: false.
	self build
]

{ #category : #accessing }
IceTipOptionDialog >> selectedType [

	^ type
]

{ #category : #private }
IceTipOptionDialog >> selectionChanged: aType [

	type := aType.
	aType ifNotNil: [ 
		self window title: type titleForWindow.
		self replacePanelWith: type ]
]

{ #category : #'accessing - ui' }
IceTipOptionDialog >> typeList [

	^ typeList
]
