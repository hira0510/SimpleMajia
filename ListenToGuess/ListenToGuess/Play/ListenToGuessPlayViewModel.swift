//
//  ListenToGuessPlayViewModel.swift
//  ListenToGuess
//
//  Created by  on 2021/11/25.
//

import UIKit
import MediaPlayer

class ListenToGuessPlayViewModel: NSObject {
    
    public var player: AVPlayer?
    public var musicIndex: Int = 0
    public var trueIndex: Int = 0
    public var trueCount: Int = 0
    
    public var musicStr = ["Ancient Forest", "Aqua Dungeon Deep Sea", "Aquarium", "Ariant Hot Desert", "Ariant", "Blue World", "Cash Shop", "Castle Outside", "Cava Bien", "China Go Shanghai", "El Nath Snowy Village", "El Nath Warm Regard", "Ellin Forest", "Ellinia Missing You", "Ellinia Moonlight Shadow", "Ellinia When the Morning Comes", "Ereve Queens Garden", "Ereve Raindrop Flower", "Florina Beach Beachway", "Haunted House", "Henesys Floral Life", "Henesys Go Picnic", "Henesys Rest N Peace", "Herb Town Pirate", "Interior of Nautilus", "Kerning City Bad Guys", "Kerning City Jungle Book", "Kerning Square Field", "Kerning Square Subway", "Kerning Square", "Korean Folk Town Downtown", "Leafre Minars Dream", "Leafre", "Lith Harbor Above the Treetops", "Ludibrium Dark Shadow", "Ludibrium Fairytale", "Ludibrium Fantasia", "Ludibrium Fantastic Thinking", "Ludibrium Flying in a Blue Dream", "Ludibrium Funny Time Maker", "Ludibrium High Enough", "Ludibrium Theyre Menacing You", "Ludibrium Timeless", "Ludibrium Waltz for Work", "Ludibrium Wherever You Are", "Magatia Dispute", "Malaysia Highland", "Maple Island First Step Master", "Mu Lung Forest", "Mu Lung Hill", "Mushroom Castle Blue Sky", "Mushroom Shrine Feeling", "Nautilus", "Night Market", "Orbis Arab Pirate", "Orbis Come with Me", "Orbis Plot of Pixie", "Orbis Shinin Harbor", "Orbis Tower of Goddess", "Orbis Upon the Sky", "Perion Highland Star", "Perion Nightmare", "Shining Sea", "Showa Yume", "Sleepywood Ancient Move", "Sleepywood Evil Eyes", "Sleepywood", "Title", "White Herb"]

    public func playTheBgSong(_ key: String) -> AVPlayer? {
        player = nil
        if let url = Bundle.main.url(forResource: key, withExtension: "mp3") {
            let players = AVPlayer(url: url)
            player = players
            let value = Int.random(in: 0...100)
            let seconds = Int64(value)
            let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
            players.seek(to: targetTime)
            players.play()
            return players
        }
        return nil
    }
}
