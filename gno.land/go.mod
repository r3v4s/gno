module github.com/gnolang/gno/gno.land

go 1.21

require (
	github.com/cockroachdb/apd/v3 v3.2.1
	github.com/gnolang/gno/gnovm v0.0.0-00010101000000-000000000000
	github.com/gnolang/gno/tm2 v0.0.0-00010101000000-000000000000
	github.com/gorilla/mux v1.8.1
	github.com/gotuna/gotuna v0.6.0
	github.com/jaekwon/testify v1.6.1
	github.com/peterbourgon/ff/v3 v3.4.0
	github.com/rogpeppe/go-internal v1.12.0
	github.com/stretchr/testify v1.8.4
	go.uber.org/zap v1.26.0
	go.uber.org/zap/exp v0.2.0
)

require (
	dario.cat/mergo v1.0.0 // indirect
	github.com/btcsuite/btcd/btcec/v2 v2.3.2 // indirect
	github.com/btcsuite/btcd/btcutil v1.1.3 // indirect
	github.com/cespare/xxhash v1.1.0 // indirect
	github.com/cespare/xxhash/v2 v2.2.0 // indirect
	github.com/cosmos/ledger-cosmos-go v0.13.3 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/decred/dcrd/dcrec/secp256k1/v4 v4.2.0 // indirect
	github.com/dgraph-io/badger/v3 v3.2103.5 // indirect
	github.com/dgraph-io/ristretto v0.1.1 // indirect
	github.com/dustin/go-humanize v1.0.0 // indirect
	github.com/gnolang/goleveldb v0.0.9 // indirect
	github.com/gnolang/overflow v0.0.0-20170615021017-4d914c927216 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/glog v1.1.2 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/google/flatbuffers v2.0.8+incompatible // indirect
	github.com/gorilla/securecookie v1.1.1 // indirect
	github.com/gorilla/sessions v1.2.1 // indirect
	github.com/gorilla/websocket v1.5.1 // indirect
	github.com/jmhodges/levigo v1.0.0 // indirect
	github.com/klauspost/compress v1.15.9 // indirect
	github.com/libp2p/go-buffer-pool v0.1.0 // indirect
	github.com/linxGnu/grocksdb v1.8.11 // indirect
	github.com/pelletier/go-toml v1.9.5 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/rs/cors v1.10.1 // indirect
	github.com/tecbot/gorocksdb v0.0.0-20191217155057-f0fad39f321c // indirect
	github.com/zondax/hid v0.9.2 // indirect
	github.com/zondax/ledger-go v0.14.3 // indirect
	go.etcd.io/bbolt v1.3.8 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.uber.org/multierr v1.10.0 // indirect
	golang.org/x/crypto v0.19.0 // indirect
	golang.org/x/mod v0.15.0 // indirect
	golang.org/x/net v0.21.0 // indirect
	golang.org/x/sys v0.17.0 // indirect
	golang.org/x/term v0.17.0 // indirect
	golang.org/x/text v0.14.0 // indirect
	golang.org/x/tools v0.18.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20231120223509-83a465c0220f // indirect
	google.golang.org/grpc v1.59.0 // indirect
	google.golang.org/protobuf v1.32.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)

replace github.com/gnolang/gno/tm2 => ../tm2

replace github.com/gnolang/gno/gnovm => ../gnovm
