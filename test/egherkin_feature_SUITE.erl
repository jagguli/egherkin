%% Copyright (c) 2018, Jabberbees SAS

%% Permission to use, copy, modify, and/or distribute this software for any
%% purpose with or without fee is hereby granted, provided that the above
%% copyright notice and this permission notice appear in all copies.

%% THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
%% WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
%% MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
%% ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
%% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
%% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
%% OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

%% @author Emmanuel Boutin <emmanuel.boutin@jabberbees.com>

-module(egherkin_feature_SUITE).
-compile(export_all).

-include_lib("common_test/include/ct.hrl").
-include_lib("assert.hrl").

init_per_suite(Config) ->
	Config.

end_per_suite(Config) ->
	Config.

init_per_testcase(_TestCase, Config) ->
	Config.

end_per_testcase(_TestCase, Config) ->
	Config.

all() -> [
	name_works,
    
	tags_works,

	tag_names_works,

	background_works,

    scenario_returns_scenario,
    scenario_returns_false,

    scenario_names_works
].

%%region name

name_works(_) ->
	Feature = test_data:parse_output(simple_scenario),
	?assertEqual(<<"Addition">>, egherkin_feature:name(Feature)),
	ok.

%%endregion

%%region tags

tags_works(_) ->
	Feature = test_data:parse_output(feature_tags),
	?assertEqual([{1,<<"critical">>},{2,<<"non-regression">>},{2,<<"ui">>}],
		egherkin_feature:tags(Feature)),
	ok.

%%endregion

%%region tag_names

tag_names_works(_) ->
	Feature = test_data:parse_output(feature_tags),
	?assertEqual([<<"critical">>,<<"non-regression">>,<<"ui">>],
		egherkin_feature:tag_names(Feature)),
	ok.

%%endregion

%%region background

background_works(_) ->
	Feature = test_data:parse_output(background),
	?assertMatch({2, [_, _, _, _]},
		egherkin_feature:background(Feature)),
	ok.

%%endregion

%%region scenario

scenario_returns_scenario(_) ->
	Feature = test_data:parse_output(simple_scenario),
	?assertMatch({2, <<"Add two numbers">>, [], _},
        egherkin_feature:scenario(Feature, <<"Add two numbers">>)),
	ok.

scenario_returns_false(_) ->
	Feature = test_data:parse_output(simple_scenario),
	?assertEqual(false, egherkin_feature:scenario(Feature, <<"foo">>)),
	ok.

%%endregion

%%region scenario_names

scenario_names_works(_) ->
	Feature = test_data:parse_output(simple_scenario),
	?assertEqual([<<"Add two numbers">>], egherkin_feature:scenario_names(Feature)),
	ok.

%%endregion
