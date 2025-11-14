import Foundation

var nomeJogador = ""
var jogoRoda: Bool = true
var itemLoc: [Local: String] = [:]
var inventario: Set<String> = []

enum Local: Int{
    case florestaSombria = 1
    case montanhasDoDesespero = 2
    case cavernaAmaldicoada = 3
    case ruinasDoPortal = 4
    case def = 5
}

enum ErroOpcao: Error {
    case nulo, nExiste
}

func introJogo(){
    print("")
    print("------------------------------------------------------------")
    print("    A ILHA PROIBIDA - by Pedro Henrique Hossaka Teruel     ")
    print("------------------------------------------------------------")
    print("")
    print("Você é um jovem guerreiro do reino de Teruel, que foi convocado para uma missão em terras extrangeiras. Durante essa missão, um de seus aliados traiu o reino, e armou uma emboscada para você.")
    print("")
    print("Na tentativa voltar para o reino e avisar o Rei sobre a traição, seu barco é destruido perto das Ilhas Proibidas, onde nem os melhores guerreiros conseguiram sair.")
    print("")
    print("Seu objetivo então, se torna reunir 4 artefatos mágicos para reconstruir um antigo portal localizado no centro da ilha, para entao retornar ao reino e avisar o Rei.")
    print("")
}

func nomeGuerreiro(){
    print("Qual é o seu nome guerreiro?")
    print("Digite seu nome: ")
    
    let nomeLinha = readLine()
    if let nome = nomeLinha{
        if nome.isEmpty{
            nomeJogador = "Guerreiro Anonimo"
        }else{
            
            nomeJogador = nome
        }
    }else{
        nomeJogador = "Guerreiro Anonimo"
    }
    
    print("")
    print("Muito bem \(nomeJogador)! A Ilha Proibida espera por você...")
    print("")
}

func menu(){
    while jogoRoda == true{
        print("")
        print("                    ESCOLHA UMA OPÇÃO")
        print("1- Explorar a ilha")
        print("2- Ver inventário")
        print("3- Ver seu objetivo principal")
        print("4- Sair do jogo")
        print("")
        print("Escolha uma opção: ")
        let opcao = lerOpcao()
        if let numero = opcao{
            switch numero{
            case 1:
                explorarIlha()
            case 2:
                mostrarInventario()
            case 3:
                mostrarObjetivo()
            case 4:
                sairJogo()
            default:
                print("Opção inválida, digite um numero válido.")
            }
        }else{
            print("Opção inválida, digite um numero válido.")
        }
    }
}


func lerOpcao() -> Int?{
    let opcaoLinha = readLine() ?? ""
    let texto = Int(opcaoLinha)
    return texto
}

func explorarIlha(){
    print("")
    print("                    LOCAIS DA ILHA PROIBIDA")
    print("1- Floresta Sombria")
    print("2- Montanhas do Desespero")
    print("3- Caverna Amaldiçoada")
    print("4- Ruínas do Portal")
    print("")
    print("Escolha um local para explorar: ")
    
    let mapaEscolhas: [Int: Local] = [
        1: .florestaSombria,
        2: .montanhasDoDesespero,
        3: .cavernaAmaldicoada,
        4: .ruinasDoPortal
    ]
    let entrada = lerOpcao()
    if let valor = entrada {
        
        
        func checarOpcao(_ opcao: Int) throws -> String{
            if opcao == 0{
                throw ErroOpcao.nulo
            }else if let loc = mapaEscolhas[valor]{
                if loc in 1...4{
                    explorar(local: loc)
                }else{
                    throw ErroOpcao.nExiste
                }
                
            }
        }
        
        
        if let loc = mapaEscolhas[valor]{
            explorar(local: loc)
        }else{
            print("Local inválido, escolha um local válido.")
        }
    }else{
        print("Local inválido, escolha um local válido.")
    }
}

func sairJogo(){
    print("")
    print("Você escolheu encerrar sua jornada e ficou preso na Ilha Proibida para sempre...")
    jogoRoda = false
}

func comecarJogo(){
    configItens()
    introJogo()
    nomeGuerreiro()
    menu()
}

let eventosRandom: [String] = ["Uma entidade anciã apareceu, falou em uma língua desconhecida e desapareceu.","Um pequeno goblin pegou a sua comida e fugiu, rindo maldosamente.","Você encontrou marcas de garras na parede, mas felizmente nenhum inimigo à vista."]

let descricaoLoc: [Local: String] = [
    .florestaSombria: "Você segue o caminho  que leva a Floresta Sombria, onde as arvores sussuram feitiços em uma lingua desconhecida",
    .montanhasDoDesespero: "Você escala as Montanhas do Desespero, onde os ventos congelam até os mais esperançosos",
    .cavernaAmaldicoada: "Você adentra a Caverna Amaldiçoada. a casa dos morcegos gigantes e criaturas desconhecidas",
    .ruinasDoPortal: "Você chega às Ruínas do Portal, no centro da ilha, onde as pedras estâo marcadas com feitiços de proteção, porem, o portal esta quebrado"
]

let nomeLugar: [Local: String] = [
    .florestaSombria: "Floresta Sombria",
    .montanhasDoDesespero: "Montanhas do Desespero",
    .cavernaAmaldicoada: "Caverna Amaldiçoada",
    .ruinasDoPortal: "Ruínas do Portal"
]

let nomeItens: [String] = ["Pedra forjada pelos goblins anciãos", "Cristal da sabedoria", "Chama da esperança", "Pergaminho guia do portal"]

func configItens() {
    itemLoc[.florestaSombria] = "Pedra forjada pelos goblins anciãos"
    itemLoc[.montanhasDoDesespero] = "Cristal da sabedoria"
    itemLoc[.cavernaAmaldicoada] = "Chama da esperança"
    itemLoc[.ruinasDoPortal] = "Pergaminho guia do portal"
}

func explorar(local: Local) {
    print("")
    
    if let desc = descricaoLoc[local] {
        print(desc)
    }
    let chance = Int.random(in: 0...99)
    if chance < 50 {
        encontrarItem(in: local)
    } else if chance < 75 {
        mostrarEventoNarrativo()
    } else {
        print("Nada de interessante foi encontrado.")
    }
    verificarConclusao()
}

func encontrarItem(in local: Local) {
    let artefato = itemLoc[local]
    
    if let item = artefato {
        if inventario.contains(item) {
            print("Você sente a energia do artefato magico que já coletou aqui.")
        } else {
            print("PARABENS, VOCE ENCONTROU UM ARTEFATO MAGICO! ")
            print("ARTEFATO OBTIDO: \(item)")
            inventario.insert(item)
        }
    } else {
        print("Você sente magia no ar, mas não encontra nada. e deve procurar aqui mais tarde!")
    }
}

func mostrarEventoNarrativo() {
    if eventosRandom.isEmpty {
        print("O silêncio domina o local...")
    } else {
        let x = Int.random(in: 0..<eventosRandom.count)
        print("Evento misterioso:")
        print(eventosRandom[x])
    }
}

func mostrarInventario() {
    print("")
    print("                    INVENTÁRIO")
    
    if inventario.isEmpty {
        print("Nenhum artefato coletado ainda.")
    } else {
        for item in inventario {
            print("- \(item)")
        }
    }
    
    print("ARTEFATOS COLETADOS: \(inventario.count)/\(nomeItens.count)")
}

func mostrarObjetivo() {
    print("")
    print("                    OBJETIVO")
    
    var i = 0
    while i < nomeItens.count {
        let item = nomeItens[i]
        var prog = "[ ]"
        
        if inventario.contains(item) {
            prog = "[X]"
        }
        
        print("\(prog) \(item)")
        i = i + 1
    }
}

func verificarConclusao() {
    if inventario.count == nomeItens.count {
        print("")
        print("          TODOS OS ARTEFATOS FORAM REUNIDOS!")
        print("")
        print("O portal é reconstruido utilizando os artificios coletados durante a jornada. Agora, \(nomeJogador) pode retornar ao Reino Teruel!")
        print("")
        jogoRoda = false
    }
}


comecarJogo()
