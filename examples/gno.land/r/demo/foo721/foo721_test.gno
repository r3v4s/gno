package foo721

import (
	"std"
	"testing"

	"gno.land/p/demo/grc/grc721"
	"gno.land/r/demo/users"
)

func TestFoo721(t *testing.T) {
	admin := users.AddressOrName("g1us8428u2a5satrlxzagqqa5m6vmuze025anjlj")
	hariom := users.AddressOrName("g1var589z07ppjsjd24ukm4uguzwdt0tw7g47cgm")

	for _, tc := range []struct {
		name     string
		expected interface{}
		fn       func() interface{}
	}{
		{"BalanceOf(admin)", 10, func() interface{} { return BalanceOf(admin) }},
		{"BalanceOf(hariom)", 5, func() interface{} { return BalanceOf(hariom) }},
		{"OwnerOf(0)", admin.Resolve(), func() interface{} { return OwnerOf(grc721.TokenID("0")) }},
		{"IsApprovedForAll(admin, hariom)", false, func() interface{} { return IsApprovedForAll(admin, hariom) }},
		{"GetBaseURI()", "gno.land/nft/", func() interface{} { return GetBaseURI() }},
	} {
		t.Run(tc.name, func(t *testing.T) {
			got := tc.fn()
			if tc.expected != got {
				t.Errorf("expected: %v got: %v", tc.expected, got)
			}
		})
	}

	// TokenURIs
	std.TestSetOrigCaller(admin.Resolve())
	SetBaseURI("gno.land/this_is_new_nft/")
	shouldEqual(t, "gno.land/this_is_new_nft/", GetBaseURI())

	SetTokenURI(grc721.TokenID("0"), "nft-0.json")
	uri, err := foo.TokenURI(grc721.TokenID("0"))
	if err != nil {
		panic(err)
	}

	shouldEqual(t, "gno.land/this_is_new_nft/nft-0.json", uri)
	/*
	{
		"name": "gnoland_logo",
		"description": "logo png file from staging.gno.land",
		"ipfs_cid": "QmRFBPH68vsc3xTKzpSKLHmhFo3DAKAxEo4Dn9j6teJTdg",
	}
	*/
}


/*
	HELPER
*/
func shouldEqual(t *testing.T, expected, got interface{}) {
	if expected != got {
		t.Errorf("expected: %v got: %v", expected, got)
	}
}