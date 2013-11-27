if Rails.env.production?
  AlgoliaSearch.configuration = { application_id: 'N72WVN6AGV', api_key: 'c80bb1dadcf4b9c879d8db706f33e0aa' }
else
  AlgoliaSearch.configuration = { application_id: 'V6QF7NN0BZ', api_key: '6865e09c74975b5eee01047a5593781e' }
end