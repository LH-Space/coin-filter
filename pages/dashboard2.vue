<template>
    <Layout>
    </Layout>
    <div class="container">
        <h1>Currency Dashboard</h1>
        <div class="overall-status">
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
                    <tr v-for="currency in currencies">
                        <td style="display: flex; align-items: center; ">
                            <img :src="currency.image" alt="Currency logo" style="width: 25%;" />
                            &nbsp;
                            <a>{{ currency.name }}</a>
                        </td>
                        <td>{{ currency.symbol.toUpperCase() }}</td>
                        <td style="text-align: end;">{{ currency.current_price }}</td>
                        <td style="text-align: end;">{{ currency.market_cap }}</td>
                        <td style="text-align: end;">{{ currency.price_change_24h }}</td>
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
            currencies: []
        };
    },
    mounted() {
        axios
            .get('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=500&page=1&sparkline=false&locale=en')
            .then((response) => {
                this.currencies = response.data;
                console.log(response);
            })
            .catch((error) => {
                console.log(error);
            });
    },

};
</script>
  