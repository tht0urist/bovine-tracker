//
// Copyright © 2019 ObjectBox Ltd. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

extension Date {
    init(unixTimestamp: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(unixTimestamp) / 1000.0)
    }
    
    init(unixTimestampNanos: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(unixTimestampNanos) / 1000000000.0)
    }

    var unixTimestamp: Int64 {
        let offset: TimeInterval = (timeIntervalSince1970 > 0) ? 0.5 : -0.5
        return Int64(timeIntervalSince1970 * 1000.0 + offset)
    }

    var unixTimestampNanos: Int64 {
        let offset: TimeInterval = (timeIntervalSince1970 > 0) ? 0.5 : -0.5
        return Int64(timeIntervalSince1970 * 1000000000.0 + offset)
    }
}
