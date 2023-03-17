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
	} {
		t.Run(tc.name, func(t *testing.T) {
			got := tc.fn()
			if tc.expected != got {
				t.Errorf("expected: %v got: %v", tc.expected, got)
			}
		})
	}
}

func TestFoo721Metadata(t *testing.T) {
	admin := users.AddressOrName("g1us8428u2a5satrlxzagqqa5m6vmuze025anjlj")
	nonAdmin := users.AddressOrName("g1var589z07ppjsjd24ukm4uguzwdt0tw7g47cgm")

	// TokenURIs
	shouldEqual(t, "gno.land/nft/", GetBaseURI())
	
	std.TestSetOrigCaller(admin.Resolve())
	SetBaseURI("gno.land/this_is_new_nft/")
	shouldEqual(t, "gno.land/this_is_new_nft/", GetBaseURI())

	SetTokenURI(grc721.TokenID("0"), "nft-0.json")
	uri := GetTokenURI(grc721.TokenID("0"))
	shouldEqual(t, "gno.land/this_is_new_nft/nft-0.json", uri)
	/* example) TokenURI JSON structure
	{
		"name": "gnoland_logo",
		"description": "logo png file from staging.gno.land",
		"ipfs_cid": "QmRFBPH68vsc3xTKzpSKLHmhFo3DAKAxEo4Dn9j6teJTdg",
	}
	*/

	// nonAdmin should panic
	std.TestSetOrigCaller(nonAdmin.Resolve())
	shouldPanic(t, func() {
		// this function should panic
		SetBaseURI("gno.land/this_is_new_nft_from_nonAdmin/")
	})
}


// ======================================
// ========== HELPER FUNCTIONS ==========
// ======================================

func shouldEqual(t *testing.T, expected, got interface{}) {
	if expected != got {
		t.Errorf("expected: %v got: %v", expected, got)
	}
}

func shouldPanic(t *testing.T, fn func()) {
	defer func() {
		if r := recover(); r == nil {
			t.Errorf("expected panic")
		}
	}()
	fn()
}