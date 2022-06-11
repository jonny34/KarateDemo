function fn() {
    var env = karate.env;
    karate.log('Environment: ', env);

    if (!env) {
        //If no env set default to dev
        env = 'dev';
        console.log("No Environment selected, defaulting to Dev.");
    }

    var config = {
        env: env,
        //Product ID Generator
        PIDAuth: '',
        PIDBaseUrl: '',
        //Consumer Service
        CSAuth: '',
        CSBaseUrl: ''
    };

    if (env == 'dev') {
        console.log("Environment: ", env);
        //Product ID Generator
        config.PIDAuth = '',
        config.PIDBaseUrl = '';
        //Consumer Service
        config.CSAuth = '',
        config.CSBaseUrl = '';

    } else

    if (env == 'test') {
        console.log("Environment: ", env);
        //Product ID Generator
        config.PIDAuth = '',
        config.PIDBaseUrl = '';
        //Consumer Service
        config.CSAuth = '',
        config.CSBaseUrl = '';
    } else

    if (env == 'e2e') {
        console.log("Environment: ", env);
        //Product ID Generator
        config.PIDAuth = '',
        config.PIDBaseUrl = '';
        //Consumer Service
        config.CSAuth = '',
        config.CSBaseUrl = '';
    }
    return config;
}