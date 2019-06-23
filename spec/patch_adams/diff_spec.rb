describe '#diff' do
  it { expect({}.diff({})).to eq deletions: {}, additions: {} }
  it { expect({foo: 1}.diff({})).to eq deletions: {foo: 1}, additions: {} }
  it { expect({}.diff({bar: 2})).to eq deletions: {}, additions: {bar: 2} }
  it { expect({foo: 1}.diff({bar: 2})).to eq deletions: {foo: 1}, additions: {bar: 2} }
  it { expect({foo: 1, bar: 2, baz: 7}.diff({bar: 2, foo: 1, bax: 3})).to eq deletions: {baz: 7}, additions: {bax: 3} }
end

describe '#deep_diff' do
  it { expect({}.deep_diff({})).to eq deletions: {}, additions: {} }
  it { expect({foo: 1}.deep_diff({})).to eq deletions: {foo: 1}, additions: {} }
  it { expect({}.deep_diff({bar: 2})).to eq deletions: {}, additions: {bar: 2} }
  it { expect({foo: 1}.deep_diff({bar: 2})).to eq deletions: {foo: 1}, additions: {bar: 2} }
  it { expect({foo: 1, bar: 2, baz: 7}.deep_diff({bar: 2, foo: 1, bax: 3})).to eq deletions: {baz: 7}, additions: {bax: 3} }

  it { expect({foo: {baz: 2}}.deep_diff({bar: {baz: 2}})).to eq deletions: {foo: {baz: 2}}, additions: {bar: {baz: 2}} }
  it { expect({foo: {baz: 2}}.deep_diff({foo: {baz: 3}})).to eq deletions: {foo: {baz: 2}}, additions: {foo: {baz: 3}} }

  it { expect({foo: {baz: 2, bax: 8}}.deep_diff({foo: {baz: 3, bax: 8}})).to eq deletions: {foo: {baz: 2}},
                                                                                additions: {foo: {baz: 3}} }
  it { expect({foo: 4}.deep_diff({foo: {baz: 3, bax: 8}})).to eq deletions: {foo: 4},
                                                                 additions: {foo: {baz: 3, bax: 8}} }
  it { expect({foo: [4, 5]}.deep_diff({foo: [6, 5]})).to eq deletions: {foo: [4]},
                                                            additions: {foo: [6]} }
  it { expect({foo: [{}, 5]}.deep_diff({foo: [{}, 5]})).to eq deletions: {}, additions: {} }

  it { expect({elements: []}.deep_diff({elements: ['foo', 'bar']})).to eq deletions: {elements: []}, additions: {elements: ['foo', 'bar']} }
  it { expect({elements: ['foo', 'bar']}.deep_diff({elements: []})).to eq deletions: {elements: ['foo', 'bar']}, additions: {elements: []} }

  it { expect({foo: [{bar: 4}, 5]}.deep_diff({foo: [{bar: 5}, 5]})).to eq deletions: {foo: [{bar: 4}]},
                                                                          additions: {foo: [{bar: 5}]}}
  it { expect({foo: [{bar: 4, bax: 9}, 5]}.deep_diff({foo: [{bar: 5, bax: 9}, 5]})).to eq deletions: {foo: [{bar: 4}]},
                                                                                          additions: {foo: [{bar: 5}]}}
  it { expect({foo: {baz: 2, bax: {}}}.deep_diff({foo: {baz: 3, bax: {}}})).to eq deletions: {foo: {baz: 2}},
                                                                                  additions: {foo: {baz: 3}} }
  it { expect({foo: {bax: {kux: 4, bar: 9}, baz: 10}}.deep_diff({foo: {bax: {kux: 3, bar: 9}, baz: 10}})).to eq deletions: {foo: {bax: {kux: 4}}},
                                                                                                                additions: {foo: {bax: {kux: 3}}} }
end
