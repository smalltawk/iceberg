"Shutdown Libgit"
LGitLibrary shutDown: true.

"Unregister all iceberg repository adapters since we are going to unload all code related to it.
Otherwise obsolete instances will stay".
IceMetacelloRepositoryAdapter allInstances do: #unregister.
Smalltalk globals at: #IceSystemEventListener ifPresent: #unregisterSystemAnnouncements.

"Workaround to avoid keeping an entry in World Menu to the obsolete class."
(IceTipRepositoriesBrowser class>>#menuCommandOn:) removeFromSystem.

"Remove iceberg from system (so I can reload it)"
MetacelloPharoPlatform select.
#(
    'BaselineOfTonel'
    'BaselineOfLibGit'
    'BaselineOfIceberg'
    'MonticelloTonel-Core'
    'MonticelloTonel-FileSystem'
    'MonticelloTonel-Tests'
    'Iceberg-UI' 
    'Iceberg-TipUI'
    'Iceberg-Plugin-Pharo' 
    'Iceberg-Plugin-Metacello' 
    'Iceberg-Plugin-GitHub'
    'Iceberg-Plugin-Migration'
    'Iceberg-Plugin' 
    'Iceberg-Metacello-Integration' 
    'Iceberg-Libgit-Tonel' 
    'Iceberg-Libgit-Filetree' 
    'Iceberg-Libgit' 
    'Iceberg-Tests'
    'Iceberg-Memory'
    'Iceberg-UI-Tests'
    'Iceberg-Core' 
    'Iceberg-Changes' 
    'Iceberg-Adapters' 
    'Iceberg'
    'Iceberg-GitCommand'
    'Iceberg-SmartUI'
    'Iceberg-Pharo6'
    'LibGit-Core')
do: [ :each |
    (each asPackageIfAbsent: [ 
        (each , ' not found') traceCr.
        nil ])
            ifNotNil: [ :package |
                ('Removing ', each) traceCr.
                package removeFromSystem ] ].

"Loading Tonel before trying to load Iceberg.
This is required to load iceberg packages and dependencies in Tonel format"
Metacello new
    baseline: 'Tonel';
    repository: 'github://pharo-vcs/tonel:v1.0.17';
    load.

"Development branch requires latest Spec2"
Metacello new
    githubUser: 'pharo-spec' project: 'Spec' commitish: 'Pharo10' path: 'src';
    baseline: 'Spec2';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load
