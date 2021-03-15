//
//  ViewController.swift
//  SSBCharacters Ban
//
//  Created by Kevin Rojas on 12/22/17.
//  Copyright © 2017 Kevin Rojas. All rights reserved.
//

import UIKit
import FMMosaicLayout
import AVFoundation

struct Character {
    let name: String
    let image: String
    let audio: String
}

class ViewController: UICollectionViewController, FMMosaicLayoutDelegate {
    var allCharacters: [Character] = []
    var allCharactersAux: [Character] = []
    var charactersBanned: [Character] = []
    var isBanned: Bool = false
    var audioItems: [AVPlayerItem] = []
    var aVQueuePlayer: AVQueuePlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mosaicLayout: FMMosaicLayout = FMMosaicLayout.init()
        self.collectionView?.collectionViewLayout = mosaicLayout
        
        self.collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: "carouselCellId")
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        allCharacters = [
            Character(name: "Bayonetta", image: "Bayonetta-Profile-Square", audio: "snd_se_narration_characall_Bayonetta"),
            Character(name: "Bowser", image: "Bowser-Profile-Square", audio: "snd_se_narration_characall_Koopa"),
            Character(name: "Bowser Jr.", image: "Bowser-Jr-Profile-Square", audio: "snd_se_narration_characall_Koopajr"),
            Character(name: "Captain Falcon", image: "Captain-Falcon-Profile-Square", audio: "snd_se_narration_characall_Captain"),
            Character(name: "Charizard", image: "Charizard-Profile-Square", audio: "snd_se_narration_characall_PokeLizardon"),
            Character(name: "Cloud", image: "Cloud-Profile-Square", audio: "snd_se_narration_characall_Cloud"),
            Character(name: "Corrin", image: "Corrin-F-Profile-Square", audio: "snd_se_narration_characall_Kamui"),
            Character(name: "Dark Pit", image: "Dark-Pit-Profile-Square", audio: "snd_se_narration_characall_PitB"),
            Character(name: "Diddy Kong", image: "Diddy-Kong-Profile-Square", audio: "snd_se_narration_characall_Diddy"),
            Character(name: "Donkey Kong", image: "Donkey-Kong-Profile-Square", audio: "snd_se_narration_characall_Donkey"),
            Character(name: "Dr Mario", image: "Dr-Mario-Profile-Square", audio: "snd_se_narration_characall_MarioD"),
            Character(name: "Duck Hunt", image: "Duck-Hunt-Profile-Square", audio: "snd_se_narration_characall_Duckhunt"),
            Character(name: "Falco", image: "Falco-Profile-Square", audio: "snd_se_narration_characall_Falco"),
            Character(name: "Fox", image: "Fox-Profile-Square", audio: "snd_se_narration_characall_Fox"),
            Character(name: "Ganondorf", image: "Ganondorf-Profile-Square", audio: "snd_se_narration_characall_Ganon"),
            Character(name: "Greninja", image: "Greninja-Profile-Square", audio: "snd_se_narration_characall_Gekkouga"),
            Character(name: "Ike", image: "Ike-Profile-Square", audio: "snd_se_narration_characall_Ike"),
            Character(name: "Jigglypuff", image: "Jigglypuff-Profile-Square", audio: "snd_se_narration_characall_Purin"),
            Character(name: "King Dedede", image: "King-Dedede-Profile-Square", audio: "snd_se_narration_characall_Dedede"),
            Character(name: "Kirby", image: "Kirby-Profile-Square", audio: "snd_se_narration_characall_Kirby"),
            Character(name: "Link", image: "Link-Profile-Square", audio: "snd_se_narration_characall_Link"),
            Character(name: "Little Mac", image: "Little-Mac-Profile-Square", audio: "snd_se_narration_characall_Littlemac"),
            Character(name: "Lucario", image: "Lucario-Profile-Square", audio: "snd_se_narration_characall_Lucario"),
            Character(name: "Lucas", image: "Lucas-Profile-Square", audio: "snd_se_narration_characall_Lucas"),
            Character(name: "Lucina", image: "Lucina-Profile-Square", audio: "snd_se_narration_characall_Lucina"),
            Character(name: "Luigi", image: "Luigi-Profile-Square", audio: "snd_se_narration_characall_Luigi"),
            Character(name: "Mario", image: "Mario-Profile-Square", audio: "snd_se_narration_characall_mario"),
            Character(name: "Marth", image: "Marth-Profile-Square", audio: "snd_se_narration_characall_Marth"),
            Character(name: "Mega Man", image: "Mega-Man-Profile-Square", audio: "snd_se_narration_characall_Rockman"),
            Character(name: "Meta Knight", image: "Meta-Knight-Profile-Square", audio: "snd_se_narration_characall_Metaknight"),
            Character(name: "Mewtwo", image: "Mewtwo-Profile-Square", audio: "snd_se_narration_characall_Mewtwo"),
            //Character(name: "Mii Brawler", image: "Mii-Brawler-Profile-Square", audio: "snd_se_narration_characall_MiiFighter"),
            //Character(name: "Mii Gunner", image: "Mii-Gunner-Profile-Square", audio: "snd_se_narration_characall_MiiGunner"),
            //Character(name: "Mii Swordfighter", image: "Mii-Swordfighter-Profile-Square", audio: "snd_se_narration_characall_MiiSword"),
            Character(name: "Mr. Game & Watch", image: "Mr-Game-Watch-Profile-Square", audio: "snd_se_narration_characall_GameWatch"),
            Character(name: "Ness", image: "Ness-Profile-Square", audio: "snd_se_narration_characall_Ness"),
            Character(name: "Olimar", image: "Olimar-Profile-Square", audio: "snd_se_narration_characall_Pikmin"),
            Character(name: "Pac-Man", image: "Pac-Man-Profile-Square", audio: "snd_se_narration_characall_Pacman"),
            Character(name: "Palutena", image: "Palutena-Profile-Square", audio: "snd_se_narration_characall_Palutena"),
            Character(name: "Peach", image: "Peach-Profile-Square", audio: "snd_se_narration_characall_Peach"),
            Character(name: "Pikachu", image: "Pikachu-Profile-Square", audio: "snd_se_narration_characall_Pikachu"),
            Character(name: "Pit", image: "Pit-Profile-Square", audio: "snd_se_narration_characall_Pit"),
            Character(name: "R.O.B", image: "ROB-Profile-Square", audio: "snd_se_narration_characall_Robot"),
            Character(name: "Robin", image: "Robin-M-Profile-Square", audio: "snd_se_narration_characall_Reflet"),
            Character(name: "Rosalina & Luma", image: "Rosalina-Luma-Profile-Square", audio: "snd_se_narration_characall_Rosetta"),
            Character(name: "Roy", image: "Roy-Profile-Square", audio: "snd_se_narration_characall_Roy"),
            Character(name: "Ryu/Danilo Palomino", image: "Ryu-Profile-Square", audio: "snd_se_narration_characall_Ryu"),
            Character(name: "Samus", image: "Samus-Profile-Square", audio: "snd_se_narration_characall_Samus"),
            Character(name: "Sheik", image: "Sheik-Profile-Square", audio: "snd_se_narration_characall_Shiek"),
            Character(name: "Shulk", image: "Shulk-Profile-Square", audio: "snd_se_narration_characall_Shulk"),
            Character(name: "Sonic", image: "Sonic-Profile-Square", audio: "snd_se_narration_characall_Sonic"),
            Character(name: "Toon Link", image: "Toon-Link-Profile-Square", audio: "snd_se_narration_characall_Toonlink"),
            Character(name: "Villager", image: "Villager-Profile-Square", audio: "snd_se_narration_characall_Murabito"),
            Character(name: "Wario", image: "Wario-Profile-Square", audio: "snd_se_narration_characall_Wario"),
            Character(name: "Wii Fit Trainer", image: "Wii-Fit-Trainer-F-Profile-Square", audio: "snd_se_narration_characall_Wiifit"),
            Character(name: "Yoshi", image: "Yoshi-Profile-Square", audio: "snd_se_narration_characall_Yoshi"),
            Character(name: "Zelda", image: "Zelda-Profile-Square", audio: "snd_se_narration_characall_Zelda"),
            Character(name: "Zero Suit Samus", image: "Zero-Suit-Samus-Profile-Square", audio: "snd_se_narration_characall_SZerosuit"),
        ]
        
        charactersBanned = allCharacters
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

    @IBAction func banButtonDidTouch(_ sender: Any) {
        allCharactersAux = allCharacters
        charactersBanned = []
        
        isBanned = true
        
        for _ in 1...8 {
            let randomIndex = Int(arc4random_uniform(UInt32(allCharactersAux.count))) + 1
            let characterSelected = allCharactersAux[randomIndex - 1]
            charactersBanned.append(characterSelected)
            allCharactersAux.remove(at: randomIndex - 1)
        }
        
        playAudioSequence()
        
        self.collectionView?.reloadData()
    }
    
    func playAudioSequence() {
        audioItems = []
    
        for audio in charactersBanned {
            let soundFileNameURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: audio.audio, ofType: "wav", inDirectory:"Announcer")!)
            let item = AVPlayerItem(url: soundFileNameURL as URL)
            audioItems.append(item)
        }
    
        aVQueuePlayer = AVQueuePlayer(items: audioItems)
        aVQueuePlayer?.prepareForInterfaceBuilder()
        aVQueuePlayer?.play()
    }
    
    @IBAction func resetButtonDidTouch(_ sender: Any) {

        
        if !(aVQueuePlayer?.isMuted)! {
            aVQueuePlayer?.pause()
        }
        
        isBanned = false
        charactersBanned = allCharacters
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCellId", for: indexPath) as! CollectionCell
        
        cell.index = indexPath.row
        cell.isBanned = isBanned
        cell.character = charactersBanned[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersBanned.count
    }

    @nonobjc func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        if isBanned {
            return FMMosaicCellSize.big
        }
        
        return indexPath.item % 2 == 0 ? FMMosaicCellSize.big : FMMosaicCellSize.small
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
}
