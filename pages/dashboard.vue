<template>
    <Layout>
    </Layout>
    <div class="container">
        <h1>Currency Dashboard</h1>
        <div class="overall-status">
            <p>Timestamp: {{ timestamp }}</p>
            <p>Total currencies: {{ totalCurrencies }}</p>
        </div>
        <div class="button-1">
            <button @click="filterData('price')">Filter by Price</button>
        </div>
        <div class="currency-list">
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Symbol</th>
                        <th>Price</th>
                        <th>Market Cap</th>
                        <th>24h Change</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="currency in currencies" :key="currency.id">
                        <td>{{ currency.name }}</td>
                        <td>{{ currency.symbol }}</td>
                        <td>{{ currency.quote.USD.price | currencyFormat }}</td>
                        <td>{{ currency.quote.USD.market_cap | currencyFormat }}</td>
                        <td>{{ currency.quote.USD.percent_change_24h | percentFormat }}</td>
                    </tr>
                </tbody>
            </table>
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
            asc: true,
        };
    },
    mounted() {
        axios
            .get('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=500&convert=USD', {
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
    filters: {
        currencyFormat(value) {
            return new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'USD',
            }).format(value);
        },
        percentFormat(value) {
            return new Intl.NumberFormat('en-US', {
                style: 'percent',
                maximumFractionDigits: 2,
            }).format(value);
        },
    },
    methods: {
        filterData(filterBy) {
            if (filterBy === 'price') {
                this.asc = !this.asc; // Toggle asc on each click
                this.currencies.sort((a, b) => {
                    return this.asc
                        ? a.quote.USD.price - b.quote.USD.price // Ascending
                        : b.quote.USD.price - a.quote.USD.price; // Descending
                });
            } else {
                // Handle other filters if needed
            }
        },
    },
};
</script>
  