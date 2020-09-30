import Foundation

class KanjisRepository {
    private func getData() -> Data {
        guard let url = Bundle.main.url(forResource: "jlptn5Kanjis.json", withExtension: nil) else {
            fatalError("File not found")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Fail to get data")
        }
        return data
    }
    
    func getKanjis() -> Kanjis {
        do {
            let data = getData()
            let decoder = JSONDecoder()
            let kanjis = try decoder.decode(Kanjis.self, from: data)
            return kanjis
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
