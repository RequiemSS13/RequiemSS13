import { classes } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Box, Button, Section, Table } from 'tgui-core/components';
import { Window } from '../layouts';

export const RetailVendor = (props) => {
  const { act, data } = useBackend();
  let inventory = [...data.product_records];
  return (
    <Window width={425} height={600} resizable>
      <Window.Content scrollable>
        <Section title="User">
          {(data.user && (data.user.money > 0 || data.user.is_card == 1) && ((data.user.is_card == 0 && (
            <Box>
              Welcome, valued customer!
              <br />
              You seem to have $<b>{data.user.money}</b> in hand. Products over $1000 require card to purchase.
            </Box>
          )) || (data.user.is_card == 1 && (
            <Box>
              Welcome, valued customer!
              <br />
              I see you are paying with <b>card</b>. Products over $20 dollars require you to input your pin. What would you like to order?
            </Box>
          )))) || (
            <Box color="light-gray">
              No cash, no card, no service!
              <br />
              Have cash or card ready in-hand for purchase.
            </Box>
          )}
        </Section>
        <Section title="Equipment">
          <Table>
            {inventory.map((product) => {
              return (
                <Table.Row key={product.name}>
                  <Table.Cell>
                    <span
                      className={classes(['retail'+product.dimensions, product.path])}
                      style={{
                        'vertical-align': 'middle',
                      }}
                    />{' '}
                    <b>{product.name}</b>
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      style={{
                        'min-width': '95px',
                        'text-align': 'center',
                      }}
                      disabled={!data.user || (product.price > data.user.money && data.user.is_card == 0)}
                      content={product.price + ' dollars'}
                      onClick={() =>
                        act('purchase', {
                          ref: product.ref,
                          payment_item: data.user.payment_item
                        })
                      }
                    />
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
