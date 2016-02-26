//
//  Piece.swift
//  Symphonaic
//
//  Created by James Boric on 31/10/2015.
//  Copyright © 2015 Ode To Code. All rights reserved.
//

import UIKit

enum KeySig {
    
    case CSharpMajor
    
    case FSharpMajor
    
    case BMajor
    
    case EMajor
    
    case AMajor
    
    case DMajor
    
    case GMajor
    
    
    
    case CMajor
    
    
    
    case FMajor
    
    case BFlatMajor
    
    case EFlatMajor
    
    case AFlatMajor
    
    case DFlatMajor
    
    case GFlatMajor
    
    case CFlatMajor
}

class Piece {

    var compositionTitle = "Sample Title"
    
    var composer = "Sample Composer"
    
    var finalTempo = 120
    
    var timeSig = [4, 4]
    
    var instruments = []
    
    var keySignature = KeySig.CMajor
    
    var associatedSharpsForKeySig : [String] {
    
        switch keySignature {
        
            
        case .CSharpMajor:
            return ["F", "C", "G", "D", "A", "E", "B"]
       
        case .FSharpMajor:
            return ["F", "C", "G", "D", "A", "E"]
        
        case .BMajor:
            return ["F", "C", "G", "D", "A"]
        
        case .EMajor:
            return ["F", "C", "G", "D"]
        
        case .AMajor:
            return ["F", "C", "G"]
        
        case .DMajor:
            return ["F", "C"]
        
        case .GMajor:
            return ["F"]
        
        case .FMajor:
            return ["B"]
        
        case .BFlatMajor:
            return ["B", "E"]
        
        case .EFlatMajor:
            return ["B", "E", "A"]
        
        case .AFlatMajor:
            return ["B", "E", "A", "D"]
        
        case .DFlatMajor:
            return ["B", "E", "A", "D", "G"]
        
        case .GFlatMajor:
            return ["B", "E", "A", "D", "G", "C"]
        
        case .CFlatMajor:
            return ["B", "E", "A", "D", "G", "C", "F"]
        
        default:
            return []
        }
    }
}