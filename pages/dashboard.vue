<template>
    <Layout>
    </Layout>
    <div class="container">
        <h1>Currency Dashboard</h1>
        <div class="overall-status">
            <p>Timestamp: {{ timestamp }}</p>
            <p>Total currencies: {{ totalCurrencies }}</p>
        </div>
        <div class="currency-list">
            <div class="currency" v-for="currency in currencies" :key="currency.id">
                <h2>{{ currency.name }}</h2>
                <p>
                    <strong>Symbol:</strong> {{ currency.symbol }}
                </p>
                <p>
                    <strong>Price:</strong> {{ currency.quote.USD.price }} USD
                </p>
                <p>
                    <strong>Market cap:</strong> {{ currency.quote.USD.market_cap }} USD
                </p>
                <p>
                    <strong>24h change:</strong> {{ currency.quote.USD.percent_change_24h }}%
                </p>
            </div>
        </div>
    </div>
</template>
  
  
<script>
import axios from "axios";

export default {
    name: "CurrencyDashboard",
    data() {
        return {
            currencies: [],
            timestamp: "",
            totalCurrencies: 0,
        };
    },
    mounted() {
        axios
            .get('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=20&convert=USD', {
                headers: {
                    'X-CMC_PRO_API_KEY': '85c09f10-3602-4ef2-828b-a8407b9b23e4',
                },
            })
            .then((response) => {
                this.timestamp = response.data.status.timestamp;
                this.totalCurrencies = response.data.status.total_count;
                this.currencies = response.data.data;
                console.log(response);
            })
            .catch((error) => {
                console.log(error);
            });
    },
};
</script>
  