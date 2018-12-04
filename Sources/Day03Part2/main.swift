import Foundation
import Day03Lib

var claims: [String] = []
while let input = readLine(strippingNewline: true) {
  claims.append(input)
}

print(Day03Lib.findNonoverlappingClaim(claims: claims))
