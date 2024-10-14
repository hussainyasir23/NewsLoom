//
//  NewsCountry.swift
//  NewsLoom
//
//  Created by Yasir on 14/10/24.
//

import Foundation

enum NewsCountry: String, CaseIterable, Country {
    
    static var defaultCountry: NewsCountry {
        return .us
    }
    
    case ae, ar, at, au
    case be, bg, br
    case ca, ch, cn, co, cu, cz
    case de
    case eg
    case fr
    case gb, gr
    case hk, hu
    case id, ie, il, `in`, it
    case jp
    case kr
    case lt, lv
    case ma, mx, my
    case ng, nl, no, nz
    case ph, pl, pt
    case ro, rs, ru
    case sa, se, sg, si, sk
    case th, tr, tw
    case ua, us
    case ve
    case za
    
    var code: String {
        return rawValue.uppercased()
    }
    
    var name: String {
        switch self {
        case .ae: return "United Arab Emirates"
        case .ar: return "Argentina"
        case .at: return "Austria"
        case .au: return "Australia"
        case .be: return "Belgium"
        case .bg: return "Bulgaria"
        case .br: return "Brazil"
        case .ca: return "Canada"
        case .ch: return "Switzerland"
        case .cn: return "China"
        case .co: return "Colombia"
        case .cu: return "Cuba"
        case .cz: return "Czech Republic"
        case .de: return "Germany"
        case .eg: return "Egypt"
        case .fr: return "France"
        case .gb: return "United Kingdom"
        case .gr: return "Greece"
        case .hk: return "Hong Kong"
        case .hu: return "Hungary"
        case .id: return "Indonesia"
        case .ie: return "Ireland"
        case .il: return "Israel"
        case .in: return "India"
        case .it: return "Italy"
        case .jp: return "Japan"
        case .kr: return "South Korea"
        case .lt: return "Lithuania"
        case .lv: return "Latvia"
        case .ma: return "Morocco"
        case .mx: return "Mexico"
        case .my: return "Malaysia"
        case .ng: return "Nigeria"
        case .nl: return "Netherlands"
        case .no: return "Norway"
        case .nz: return "New Zealand"
        case .ph: return "Philippines"
        case .pl: return "Poland"
        case .pt: return "Portugal"
        case .ro: return "Romania"
        case .rs: return "Serbia"
        case .ru: return "Russia"
        case .sa: return "Saudi Arabia"
        case .se: return "Sweden"
        case .sg: return "Singapore"
        case .si: return "Slovenia"
        case .sk: return "Slovakia"
        case .th: return "Thailand"
        case .tr: return "Turkey"
        case .tw: return "Taiwan"
        case .ua: return "Ukraine"
        case .us: return "United States"
        case .ve: return "Venezuela"
        case .za: return "South Africa"
        }
    }
}
